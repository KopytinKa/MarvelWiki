//
//  ThumbnailDTO.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 18.11.2021.
//

import Foundation

class ThumbnailDTO: Codable {
    let path: String
    let `extension`: String
    
    init(path: String, extension: String) {
        self.path = path
        self.`extension` = `extension`
    }
}
