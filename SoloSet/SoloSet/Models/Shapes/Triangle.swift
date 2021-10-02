//
//  Triangle.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI


struct Triangle: ShapeProtocol, Shape {
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
		p.move(to: CGPoint(x: rect.maxX / 2, y: rect.maxY / 6))			// start drawing point
		p.addLine(to: CGPoint(x: 10, y: 5 * rect.maxY / 6))				// left bot
		p.addLine(to: CGPoint(x: rect.maxX - 10, y: 5 * rect.maxY / 6))	// right bot
		p.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY / 6))		// top
		return p
	}
	
	func draw() {
		
	}
}
