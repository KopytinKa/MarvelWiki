//
//  Error.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation

enum Error: LocalizedError {
     case unreachableAddress(url: URL)
     case invalidResponse
        
     var errorDescription: String? {
         switch self {
         case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
         case .invalidResponse: return "Response with mistake"
         }
     }
}
