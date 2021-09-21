//
//  SetGame.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import Foundation

struct SetGame {
	
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
