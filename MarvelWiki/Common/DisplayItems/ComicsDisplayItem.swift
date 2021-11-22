//
//  ComicsDisplayItem.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation

struct ComicsDisplayItem: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let modified: String
    let resourceURI: String
    let image: String
}
