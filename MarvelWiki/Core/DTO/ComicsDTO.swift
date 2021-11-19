//
//  ComicsDTO.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation

class ComicsDTO: Codable, ResultItemDTO {
    let id: Int
    let title: String
    let description: String?
    let modified: String
    let resourceURI: String
    let thumbnail: ThumbnailDTO
    
    init(id: Int, title: String, description: String, modified: String, resourceURI: String, thumbnail: ThumbnailDTO) {
        self.id = id
        self.title = title
        self.description = description
        self.modified = modified
        self.resourceURI = resourceURI
        self.thumbnail = thumbnail
    }
}
