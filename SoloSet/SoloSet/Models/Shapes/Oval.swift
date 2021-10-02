//
//  Oval.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct Oval: ShapeProtocol, Shape {
	var shapeType: ShapeType
	var shading: Shading
	var color: Color
	
	init(shading: Shading, color: Color) {
		shapeType = .triangle
		self.shading = shading
		self.color = color
	}
	
	func path(in rect: CGRect) -> Path {
		var p = Path()
		return p
	}
}
