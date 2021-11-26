//
//  ComicsDisplayItemFabric.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation

enum ComicsDisplayItemFabric {
    static func makeItems(with comics: [ComicsDTO]) -> [ComicsDisplayItem] {
        return comics.map {
            ComicsDisplayItem(
                id: $0.id,
                title: $0.title,
                description: $0.description,
                modified: $0.modified,
                resourceURI: $0.resourceURI,
                image: $0.thumbnail.path + $0.thumbnail.extension
            )
        }
    }
}
