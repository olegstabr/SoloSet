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
		p.move(to: CGPoint(x: rect.midX, y: rect.minY))
		p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		return p
	}
	
	func draw() {
		
	}
}
