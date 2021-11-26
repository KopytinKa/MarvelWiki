//
//  CharacterDisplayItemFabric.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation

enum CharacterDisplayItemFabric {
    static func makeItems(with characters: [CharacterDTO]) -> [CharacterDisplayItem] {
        return characters.map {
            CharacterDisplayItem(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                modified: $0.modified,
                resourceURI: $0.resourceURI,
                image: $0.thumbnail.path + $0.thumbnail.extension
            )
        }
    }
}
