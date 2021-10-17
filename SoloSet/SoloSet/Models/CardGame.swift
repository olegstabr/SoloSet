
//
//  CardGame.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct CardGame {
	private(set) var cards: [Card]
	private(set) var deck: [Card]
	
	init() {
		let startCardsCount = 12
		cards = []
		deck = []
		deck = initDeck()
		
		addCardsFromDeck(cards: &cards, deck: &deck, count: startCardsCount)
	}
	
	mutating func choose(_ card: Card) {
		let needMatchCardCount = 3
		if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
			let selectedCardsCount = cards.filter({ $0.isSelect }).count
			if selectedCardsCount < needMatchCardCount {
				cards[choosenIndex].isSelect.toggle()
				let selectedCards = cards.filter({ $0.isSelect })
				if let firstSelectedCard = selectedCards.first {
					let selectedCardWithSameShapeCount = selectedCards.filter({ $0.shape.shapeType == firstSelectedCard.shape.shapeType }).count
					if selectedCardWithSameShapeCount == needMatchCardCount {
						for cardItem in selectedCards {
							if let cardItemIndex = cards.firstIndex(where: { $0.id == cardItem.id }) {
								cards[cardItemIndex].isMatch = true
								cards[cardItemIndex].isSelect = false
							}
						}
					}
				}
			} else {
				for item in cards {
					if let cardIndex = cards.firstIndex(where: { $0.id == item.id }) {
						cards[cardIndex].isSelect = false
					}
				}
				
				cards[choosenIndex].isSelect.toggle()
			}
		}
	}
	
	mutating func addThreeCards() {
		let addCardsCount = 3
		removeMatchedCards()
		addCardsFromDeck(cards: &cards, deck: &deck, count: addCardsCount)
	}
	
	private func addCardsFromDeck(cards: inout [Card], deck: inout [Card], count: Int) {
		for index in 0..<count {
			cards.append(deck[index])
		}
		
		deck.removeSubrange(0..<count)
	}
	
	private mutating func removeMatchedCards() {
		let matchedCards = cards.filter({ $0.isMatch })
		
		for matchedCard in matchedCards {
			if let index = cards.firstIndex(where: { $0.id == matchedCard.id }) {
				cards.remove(at: index)
			}
		}
	}
	
	private mutating func initDeck() -> [Card] {
		var deck: [Card] = []
		let colors: [Color] = [.orange, .green, .blue]
		let shapeTypes: [ShapeType] = [.diamond, .triangle, .oval]
		let shadings: [Shading] = [.striped, .solid, .open]
		let shapeCount = 3
		var cardIndex = 0
		
		for idx in 1...shapeCount {
			for _ in shapeTypes {
				for shading in shadings {
					for color in colors {
						let triangle = Triangle(shading: shading, color: color, shapeCount: idx)
						let diamond = Diamond(shading: shading, color: color, shapeCount: idx)
						let oval = Oval(shading: shading, color: color, shapeCount: idx)
						deck.append(Card(id: cardIndex, shape: diamond))
						deck.append(Card(id: cardIndex + 1, shape: triangle))
						deck.append(Card(id: cardIndex + 2, shape: oval))
						cardIndex += 3
					}
				}
			}
		}
		
		deck = deck.shuffled()
		return deck
	}
	
	struct Card: Identifiable {
		var id: Int
		var shape: ShapeProtocol
		var isSelect = false
		var isMatch = false
	}
}
