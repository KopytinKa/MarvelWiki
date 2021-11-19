//
//  CharacterDTO.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation

class CharacterDTO: Codable, ResultItemDTO {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let thumbnail: ThumbnailDTO
    
    init(id: Int, name: String, description: String, modified: String, resourceURI: String, thumbnail: ThumbnailDTO) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.resourceURI = resourceURI
        self.thumbnail = thumbnail
    }
}
