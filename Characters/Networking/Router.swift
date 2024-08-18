//
//  Router.swift
//  Characters
//
//  Created by kayeli dennis on 14/08/2024.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest(with queryParams: [String: String]) throws -> URLRequest
}

enum Router {
    case fetchCharacters

    var endpoint: String {
        switch self {
        case .fetchCharacters:
            return "/character"
        }
    }

    var method: String {
        switch self {
        case .fetchCharacters:
            return "GET"
        }
    }
}

extension Router: URLRequestConvertible {
    
    func makeURLRequest(with queryParams: [String : String]) throws -> URLRequest {
        guard let baseURL = URL(string: APIConfig.baseURL) else {
            throw NetworkError.invalidURL
        }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false) else {
            throw NetworkError.unableTocreateURLComponents
        }

        components.queryItems = queryParams.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
