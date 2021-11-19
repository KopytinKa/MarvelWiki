//
//  DataDTO.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation

class DataDTO: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ResultItemDTO]

    init(offset: Int, limit: Int, total: Int, count: Int, results: [ResultItemDTO]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
    
    enum CodeKeys: CodingKey
    {
        case offset
        case limit
        case total
        case count
        case results
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        do {
            results = try container.decode ([ComicsDTO].self, forKey: .results)
        } catch {
            results = try container.decode ([CharacterDTO].self, forKey: .results)
        }
        offset = try container.decode (Int.self, forKey: .offset)
        limit = try container.decode (Int.self, forKey: .limit)
        total = try container.decode (Int.self, forKey: .total)
        count = try container.decode (Int.self, forKey: .count)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodeKeys.self)
        let resultsComics = results.compactMap{$0 as? ComicsDTO}
        if !resultsComics.isEmpty {
            try container.encode (resultsComics, forKey: .results)
        } else {
            let resultsCharacters = results.compactMap{$0 as? CharacterDTO}
            try container.encode (resultsCharacters, forKey: .results)
        }
        
        try container.encode (offset, forKey: .offset)
        try container.encode (limit, forKey: .limit)
        try container.encode (total, forKey: .total)
        try container.encode (count, forKey: .count)
    }
}
