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
	var shapeCount: Int
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .triangle
		self.shading = shading
		self.color = color
		self.shapeCount = shapeCount
	}
	
	func path(in rect: CGRect) -> Path {
		return drawTriangle(in: rect)
	}
	
	private func drawOneTriangle(path: inout Path, startPoint: CGPoint, offset: CGFloat) { 
		let maxX = startPoint.x
		let maxY = startPoint.y
		let startPoint = CGPoint(x: startPoint.x, y: startPoint.y + offset)
		
		path.move(to: startPoint)											// start drawing point
		path.addLine(to: CGPoint(x: maxX / 4, y: 5 * maxY + offset))		// left bot
		path.addLine(to: CGPoint(x: 7 * maxX / 4, y: 5 * maxY + offset))	// right bot
		path.addLine(to: startPoint)										// top
	}
	
	private func drawTriangle(in rect: CGRect) -> Path {
		var p = Path()
		let firstThirdMaxX = CGFloat(rect.maxX / 2)
		let firstThirdMaxY = CGFloat(rect.maxY / CGFloat(shapeCount))
		let startDrawPoint = CGPoint(x: firstThirdMaxX, y: firstThirdMaxY / 6)
		
		var offset = CGFloat(0)
		for _ in 0..<shapeCount {
			drawOneTriangle(path: &p, startPoint: startDrawPoint, offset: offset)
			offset += rect.maxY / CGFloat(shapeCount)
		}
		
		return p
	}
}
