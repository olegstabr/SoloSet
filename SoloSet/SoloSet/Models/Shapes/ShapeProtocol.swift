//
//  ShapeProtocol.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

protocol ShapeProtocol {
	var shapeType: ShapeType { get set }
	var shading: Shading { get set }
	var color: Color { get set }
	var shapeCount: Int { get set }
}

enum ShapeType {
	case diamond
	case triangle
	case oval
}

enum Shading {
	case solid
	case striped
	case open
}
