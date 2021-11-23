//
//  MarvelService.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation
import Combine
import CryptoSwift

final class MarvelService {
    private let sheme = "https"
    private let baseUrl = "gateway.marvel.com"
    private let apiKey = "76bee1ad563b756a2702125b490e1bc4"
    private let privateKey = "94424f8230fdeb02b5b5c795d43ef95fe6f7a849"
    private let ts = "1"
    
    private let decoder = JSONDecoder()
    
    func loadCharacterById(_ id: Int) -> AnyPublisher<ResponseBobyDTO<CharacterDTO>, Error> {
        let path = "/v1/public/characters/\(id)"
        let url = self.getUrlBy(path: path)
                
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .print("🐶")
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: ResponseBobyDTO<CharacterDTO>.self, decoder: decoder)
            .mapError({ error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachableAddress(url: url)
                default:
                    return Error.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func loadCharacters() -> AnyPublisher<ResponseBobyDTO<CharacterDTO>, Error> {
        let path = "/v1/public/characters"
        let url = self.getUrlBy(path: path)
                
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .print("🦁")
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: ResponseBobyDTO<CharacterDTO>.self, decoder: decoder)
            .mapError({ error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachableAddress(url: url)
                default:
                    return Error.invalidResponse
                }
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    func loadComicsById(_ id: Int) -> AnyPublisher<ResponseBobyDTO<ComicsDTO>, Error> {
        let path = "/v1/public/comics/\(id)"
        let url = self.getUrlBy(path: path)
                
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .print("🐭")
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: ResponseBobyDTO<ComicsDTO>.self, decoder: decoder)
            .breakpoint(receiveOutput: { value in
                return value.code != 200
            })
            .mapError({ error -> Error in
                switch error {
                case is URLError:
                    return Error.unreachableAddress(url: url)
                default:
                    return Error.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: Private
    
    private func getHash() -> String {
        let data = self.ts + self.privateKey + self.apiKey
        return data.md5()
    }
    
    private func getUrlBy(path: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.sheme
        urlComponents.host = self.baseUrl
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: self.ts),
            URLQueryItem(name: "apikey", value: self.apiKey),
            URLQueryItem(name: "hash", value: self.getHash())
        ]
        
        let url = urlComponents.url!
        return url
    }
}
