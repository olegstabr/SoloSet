//
//  Card.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import Foundation

struct Card {
	var shapesNumber: ShapesNumber
	var shape: Shape
	var shading: Shading
	var color: Color
}

enum Shape {
	case diamond
	case squiggle
	case oval
}

enum ShapesNumber: Int {
	case one = 1
	case two
	case three
}

enum Shading {
	case solid
	case striped
	case open
}

enum Color {
	case red
	case green
	case purple
}
