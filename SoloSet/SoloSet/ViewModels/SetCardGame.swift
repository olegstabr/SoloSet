//
//  SetCardGame.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import Foundation

class SetCardGame: ObservableObject {
	typealias Card = CardGame.Card
	
	@Published var model = CardGame()
	
	var cards: [Card] {
		model.cards
	}
	
	// MARK: - Intent(s)
	
	func choose(_ card: Card) {
		model.choose(card)
	}
	
	func newGame() {
		model = CardGame()
	}
}
