//
//  CharacterViewModel.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 19.11.2021.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    private let marvelService: MarvelService
    private var subscriptions: Set<AnyCancellable> = []
    
    private(set) var characters: [CharacterDTO]?
    
    @Published var characterId: Int
    @Published var items: [CharacterDisplayItem] = []
    
    init(marvelService: MarvelService, characterId: Int) {
        self.marvelService = marvelService
        self.characterId = characterId
        
        $characterId
            .flatMap { (id: Int) -> AnyPublisher<ResponseBobyDTO, Error> in
                self.marvelService.loadCharacterById(id)
                    .share()
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                if let characters = $0.data.results as? [CharacterDTO] {
                    self.characters = characters
                    self.makeDisplayItems(from: characters)
                }
            })
            .store(in: &self.subscriptions)
    }
    
    func onAppear() {
        self.fetchCharacters()
    }
    
    // MARK: Private
    
    private func fetchCharacters() {
        self.marvelService.loadCharacterById(1009146)
            .handleEvents(receiveSubscription: { _ in
                print("🐱 request will start")
            }, receiveOutput: { _ in
                print("🐱 request data received")
            }, receiveCancel: {
                print("🐱 request cancelled")
            })
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                if let characters = $0.data.results as? [CharacterDTO] {
                    self.characters = characters
                    self.makeDisplayItems(from: characters)
                }
            })
            .store(in: &self.subscriptions)
    }
    
    private func makeDisplayItems(from items: [CharacterDTO]) {
        self.items = CharacterDisplayItemFabric.makeItems(with: items)
        self.objectWillChange.send()
    }
}
