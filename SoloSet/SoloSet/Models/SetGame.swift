
//
//  SetGame.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import Foundation

struct SetGame {
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
		
	}
	
	struct Card: Identifiable {
		var id: Int
		var shape: Shape
		var shapesNumber: ShapesNumber
		var isSelect: Bool = false
	}
	
	enum ShapesNumber: Int {
		case one = 1
		case two
		case three
	}
}
