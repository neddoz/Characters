//
//  NetworkError.swift
//  Characters
//
//  Created by kayeli dennis on 14/08/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableTocreateURLComponents
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
}
