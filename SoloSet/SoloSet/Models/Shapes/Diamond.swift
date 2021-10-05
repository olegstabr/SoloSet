//
//  Diamond.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct Diamond: ShapeProtocol, Shape {
	
	var shapeType: ShapeType
	var shading: Shading
	var color: Color
	var shapeCount: Int
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .diamond
		self.shading = shading
		self.color = color
		self.shapeCount = shapeCount
	}
	
	
	func path(in rect: CGRect) -> Path {
//		p.move(to: CGPoint(x: rect.maxX / 2, y: 2 * rect.maxY / 6))			// start drawing point
//		p.addLine(to: CGPoint(x: 1 * rect.maxX / 8, y: rect.maxY / 2))		// left
//		p.addLine(to: CGPoint(x: rect.maxX / 2, y: 4 * rect.maxY / 6))		// bot
//		p.addLine(to: CGPoint(x: 7 * rect.maxX / 8, y: rect.maxY / 2))		// right
//		p.addLine(to: CGPoint(x: rect.maxX / 2, y: 2 * rect.maxY / 6))		// top
		return drawDiamond(in: rect)
	}
	
	private func drawDiamond(in rect: CGRect) -> Path {
		var p = Path()
		var offset = CGFloat(0)
		let firstThirdMaxX = CGFloat(rect.maxX / 2)
		let firstThirdMaxY = CGFloat(rect.maxY / CGFloat(shapeCount))
		let startDrawPoint = CGPoint(x: firstThirdMaxX, y: firstThirdMaxY / 6)

		for _ in 0..<shapeCount {
			drawOneDiamond(path: &p, startPoint: startDrawPoint, offset: offset)
			offset += rect.maxY / CGFloat(shapeCount)
		}

		return p
	}

	private func drawOneDiamond(path: inout Path, startPoint: CGPoint, offset: CGFloat) {
		let maxX = startPoint.x
		let maxY = startPoint.y
		let startPoint = CGPoint(x: startPoint.x, y: startPoint.y + offset)
		
		path.move(to: startPoint)			// start drawing point
		path.addLine(to: CGPoint(x: 1 * maxX / 4, y: 3 * maxY + offset))		// left
		path.addLine(to: CGPoint(x: maxX, y: 5 * maxY + offset))		// bot
		path.addLine(to: CGPoint(x: 7 * maxX / 4, y: 3 * maxY + offset))		// right
		path.addLine(to: startPoint)		// top
	}
}
