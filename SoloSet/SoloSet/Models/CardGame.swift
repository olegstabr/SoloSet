
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
	private(set) var discardPile: [Card]
	
	init() {
		let startCardsCount = 12
		cards = []
		discardPile = []
		deck = []
		deck = initDeck()
		
		_ = addCardsFromDeck(cards: &cards, deck: &deck, count: startCardsCount)
	}
	
	mutating func choose(_ card: Card) {
		let needMatchCardCount = 3
		let minSamePropertyCount = 1
		if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
			cards[choosenIndex].isSelect.toggle()
			let selectedCards = cards.filter({ $0.isSelect })
			let selectedCardsCount = selectedCards.count
			if selectedCardsCount == needMatchCardCount {
				let firstSelectedCard = selectedCards.first
				let sameShapeTypeCount = selectedCards.filter({ $0.shape.shapeType == firstSelectedCard!.shape.shapeType }).count
				let sameShapeShadingCount = selectedCards.filter({ $0.shape.shading == firstSelectedCard!.shape.shading }).count
				let sameShapeColorCount = selectedCards.filter({ $0.shape.color == firstSelectedCard!.shape.color }).count
				let sameShapeCount = selectedCards.filter({ $0.shape.shapeCount == firstSelectedCard!.shape.shapeCount }).count
				let validShapeTypeProperty = sameShapeTypeCount == needMatchCardCount || sameShapeTypeCount == minSamePropertyCount
				let validShapeShadingProperty = sameShapeShadingCount == needMatchCardCount || sameShapeShadingCount == minSamePropertyCount
				let validShapeColorProperty = sameShapeColorCount == needMatchCardCount || sameShapeColorCount == minSamePropertyCount
				let validShapeCountProperty = sameShapeCount == needMatchCardCount || sameShapeCount == minSamePropertyCount
				
				if validShapeTypeProperty && validShapeShadingProperty && validShapeColorProperty && validShapeCountProperty {
					for selectedCard in selectedCards {
						if let selectedCardIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) {
							cards[selectedCardIndex].isSelect = false
							cards[selectedCardIndex].isMatch = true
						}
					}
				}
				
				removeMatchedCards()
			} else if  selectedCardsCount > needMatchCardCount {
				for selectedCard in selectedCards {
					if selectedCard.id == card.id {
						continue
					}
					
					if let selectedCardIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) {
						cards[selectedCardIndex].isSelect = false
					}
				}
			}
		}
	}
	
	mutating func addThreeCards() -> Bool{
		let addCardsCount = 3
		return addCardsFromDeck(cards: &cards, deck: &deck, count: addCardsCount)
	}
	
	private func addCardsFromDeck(cards: inout [Card], deck: inout [Card], count: Int) -> Bool{
		var count = count
		let deckCount = deck.count
		
		if deckCount == 0 {
			return false
		}

		if deckCount < count {
			count = deckCount
		}
		
		for index in 0..<count {
			deck[index].isFaceUp = true
			cards.append(deck[index])
		}
		
		deck.removeSubrange(0..<count)
		return true
	}
	
	private mutating func removeMatchedCards() {
		let matchedCards = cards.filter({ $0.isMatch })
		
		discardPile.append(contentsOf: matchedCards)
		
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
			for shapeType in shapeTypes {
				for shading in shadings {
					for color in colors {
						var shape: ShapeProtocol
						
						switch shapeType {
						case .diamond:
							shape = Diamond(shading: shading, color: color, shapeCount: idx)
						case .triangle:
							shape = Triangle(shading: shading, color: color, shapeCount: idx)
						case .oval:
							shape = Oval(shading: shading, color: color, shapeCount: idx)
						}
						
						deck.append(Card(id: cardIndex, shape: shape))
						cardIndex += 1
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
		var isFaceUp = false
	}
}
