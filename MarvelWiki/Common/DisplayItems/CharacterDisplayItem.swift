//
//  CharacterDisplayItem.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation

struct CharacterDisplayItem: Identifiable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let image: String
}
