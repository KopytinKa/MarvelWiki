//
//  ViewController.swift
//  MarvelWiki
//
//  Created by Кирилл Копытин on 17.11.2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let marvelService = MarvelService()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - ViewModel
        
        let characterViewModel = CharacterViewModel(marvelService: self.marvelService, characterId: 1009146)
        let comicsViewModel = ComicsViewModel(marvelService: self.marvelService)
        comicsViewModel.onAppear()
        
        // MARK: - Share
        
        let shared = self.marvelService.loadCharacters()
        
        shared
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    let character = $0.data.results
                    print("Subscription 1:", character[0].name)
                }
            )
            .store(in: &self.subscriptions)
        
        shared
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                   let character = $0.data.results
                   print("Subscription 2:", character[1].name)
                }
            )
            .store(in: &self.subscriptions)
        
        // MARK: - Timer
        
        let ids = [1011334, 1010699, 1009149, 1011266, 1017851]
        
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { counter, _ in counter + 1 }
            .sink { counter in
                if counter <= ids.count {
                    characterViewModel.characterId = ids[counter - 1]
                }
            }
            .store(in: &self.subscriptions)

    }
}

