//
//  ViewController.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 17.11.2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private var subscriptions: Set<AnyCancellable> = []
    private let apiClient = MarvelService()
    let encoder = JSONEncoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiClient.loadCharacterById(1009146)
            .handleEvents(receiveSubscription: { _ in
                print("🐱 request will start")
            }, receiveOutput: { _ in
                print("🐱 request data received")
            }, receiveCancel: {
                print("🐱 request cancelled")
            })
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                if let a = $0.data.results[0] as? CharacterDTO {
                    print(a.description)
                }
            })
            .store(in: &self.subscriptions)
        
        self.apiClient.loadComicsById(82967)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                if let a = $0.data.results[0] as? ComicsDTO {
                    print(a.title)
                }
            })
            .store(in: &self.subscriptions)

    }
}

