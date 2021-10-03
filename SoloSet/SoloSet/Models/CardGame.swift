
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
			let triangle = Triangle(shading: .open, color: .red, shapeCount: 1)
			let diamond = Diamond(shading: .open, color: .red, shapeCount: 1)
			let oval = Oval(shading: .open, color: .red, shapeCount: 1)
			cards.append(Card(id: cardIndex, shape: diamond, shapesNumber: .one))
			cards.append(Card(id: startCardsCount / 3 + cardIndex, shape: triangle, shapesNumber: .one))
			cards.append(Card(id: 2 * startCardsCount / 3 + cardIndex, shape: oval, shapesNumber: .one))
		}
	}
	
	mutating func choose(_ card: Card) {
		if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
			if cards.filter({ $0.isSelect }).count < 3 {
				cards[choosenIndex].isSelect.toggle()
				let selectedCards = cards.filter({ $0.isSelect })
				if let firstCard = selectedCards.first {
					if selectedCards.filter({ $0.shape.shapeType == firstCard.shape.shapeType }).count == 3 {
						for cardItem in selectedCards {
							cards[cardItem.id].isMatch = true
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
