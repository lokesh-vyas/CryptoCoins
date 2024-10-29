//
//  NetworkError.swift
//  CryptoCoins
//
//  Created by Lokesh Vyas on 22/10/24.
//

import Foundation

enum NetworkError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case none
}
