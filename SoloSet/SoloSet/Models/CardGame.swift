
//
//  CardGame.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import Foundation

struct CardGame {
	private(set) var cards: [Card]
	
	init() {
		let startCardsCount = 12
		cards = []
		
		for cardIndex in 0..<startCardsCount / 3 {
			let triangle = Triangle(shading: .solid, color: .green, shapeCount: 3)
			let diamond = Diamond(shading: .open, color: .blue, shapeCount: 3)
			let oval = Oval(shading: .striped, color: .orange, shapeCount: 2)
			cards.append(Card(id: cardIndex, shape: diamond, shapesNumber: .one))
			cards.append(Card(id: startCardsCount / 3 + cardIndex, shape: triangle, shapesNumber: .one))
			cards.append(Card(id: 2 * startCardsCount / 3 + cardIndex, shape: oval, shapesNumber: .one))
		}
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
							}
						}
					}
				}
			} else {
				if cards[choosenIndex].isSelect {
					cards[choosenIndex].isSelect.toggle()
				}
			}
		}
	}
	
	struct Card: Identifiable {
		var id: Int
		var shape: ShapeProtocol
		var shapesNumber: ShapesNumber
		var isSelect = false
		var isMatch = false
	}
	
	enum ShapesNumber: Int {
		case one = 1
		case two
		case three
	}
}
