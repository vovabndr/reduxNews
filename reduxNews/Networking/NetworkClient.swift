//
//  NetworkClient.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

protocol NetworkClientProtocol {
  func request<T: TargetType>(_ target: T) -> SignalProducer<T.Response, NetworkError>
}

class NetworkClient: NetworkClientProtocol {
  private let baseURL: URL
  // plugin
  private let session: URLSession
  private let decoder: JSONDecoder

  init(
    baseURL: URL,
    session: URLSession = URLSession(configuration: URLSessionConfiguration.default),
    decoder: JSONDecoder = JSONDecoder()
    ) {
    self.baseURL = baseURL
    self.session = session
    self.decoder = decoder
  }
  func request<T>(_ target: T) -> SignalProducer<T.Response, NetworkError> where T: TargetType {
    return buildRequest(from: target)
      .flatMap(.latest) { [weak self] request -> SignalProducer<Response, NetworkError> in
        guard let self = self else { return SignalProducer.empty }
        return self.executeRequest(request)
      }
      .attemptMap { [decoder] response -> Result<T.Response, NetworkError> in
        do {
          let parsedObject = try decoder.decode(T.Response.self, from: response.data)
          return Result.success(parsedObject)
        } catch {
          return Result(error: tryParseError(from: response, decoder: decoder))
        }
    }
  }
  private func buildRequest<T: TargetType>(from target: T) -> SignalProducer<URLRequest, NetworkError> {
    return SignalProducer { [unowned self] () -> URLRequest in
      var fullURL = self.baseURL.appendingPathComponent(target.path)

      if  let query = target.query,
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) {

        components.queryItems = query.compactMap {
          guard let value = $0.1 as? String else { return nil}
          return URLQueryItem(name: $0.0, value: value)
        }
        fullURL = components.url ?? fullURL
      }

      var request = URLRequest(url: fullURL)
      request.httpMethod = target.method.rawValue
      request.setValue(target.contentType?.rawValue, forHTTPHeaderField: "Content-Type")
      request.httpBody = try target.getBodyData()

      return request
      }
      .mapError { NetworkError.serializationError(message: "Couldn't serialize request: \($0)") }
  }

  private func executeRequest(_ request: URLRequest) -> SignalProducer<Response, NetworkError> {
    return session.reactive.data(with: request)
      .map { data, response in
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        return Response(data: data, statusCode: statusCode)
      }
      .mapError { _ in NetworkError.unknown(message: "Network Error. Please try again later.") }
  }
}

private struct Response {
  let data: Data
  let statusCode: Int
}

private func tryParseError(from response: Response, decoder: JSONDecoder) -> NetworkError {
  do {
    let errorResponse = try decoder.decode(ErrorResponse.self, from: response.data)
    return NetworkError.apiError(code: response.statusCode, message: errorResponse.message)
  } catch {}

  do {
    let responseJSON = try JSONSerialization.jsonObject(with: response.data, options: [])
    return NetworkError.apiError(code: response.statusCode, message: "\(responseJSON)")
  } catch {
    switch response.statusCode {
    case 200, 201:
      return NetworkError.serializationError(message: "Couldn't parse response: \(error)")
    default:
      return NetworkError.apiError(code: response.statusCode, message: "\(error)")
    }
  }
}
