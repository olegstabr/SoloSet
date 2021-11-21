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
	@Published var isDeckEmpty: Bool = false
	
	var cards: [Card] {
		model.cards
	}
	
	var deck: [Card] {
		model.deck
	}
	
	var discardPile: [Card] {
		model.discardPile
	}
	
	var deckCount: Int {
		cards.count
	}
	
	// MARK: - Intent(s)
	
	func choose(_ card: Card) {
		model.choose(card)
	}
	
	func newGame() {
		model = CardGame()
	}
	
	func addThreeCards() {
		let addCardsResult = model.addThreeCards()
		
		if !addCardsResult {
			self.isDeckEmpty.toggle()
		}
	}
}
