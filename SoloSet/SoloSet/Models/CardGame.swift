
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
		
		for cardIndex in 0..<startCardsCount {
			let shape = Triangle(shading: .open, color: .red)
			cards.append(Card(id: cardIndex, shape: shape, shapesNumber: .one))
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
