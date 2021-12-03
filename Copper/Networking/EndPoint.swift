//
//  EndPoint.swift
//  Copper
//
//  Created by Richard Pickup on 30/11/2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
}

protocol Endpointable {
    var path: String { get }
    var method: HTTPMethod { get }
    var basePath: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var queryItems: [URLQueryItem] { get }
    var request: URLRequest? { get }
}

extension Endpointable {
    var parameters: [String: Any] { return [:] }
    var headers: [String : String] { return [:] }
    var queryItems: [URLQueryItem] { return [] }
    var absolutePath: String { return basePath + path }
}

enum CopperEndpoint: Endpointable {
    case orders

    var basePath: String { return "https://assessments.stage.copper.co/ios" }

    var path: String {
        switch self {
        case .orders:
            return "/orders"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .orders:
            return .get
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: basePath + path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
