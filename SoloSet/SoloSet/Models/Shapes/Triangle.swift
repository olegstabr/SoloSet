//
//  Triangle.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct Triangle: ShapeProtocol, View {
	var shapeType: ShapeType
	var shading: Shading
	var color: Color
	var shapeCount: Int
	
	let numberOfStrips: Int = 5
	let lineWidth: CGFloat = 3
	let borderLineWidth: CGFloat = 3
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .triangle
		self.shading = shading
		self.color = color
		self.shapeCount = shapeCount
	}
	
	var body: some View {
		VStack {
			ForEach(0..<shapeCount, id:\.self) { index in
				HStack(spacing: 0) {
					ForEach(0..<numberOfStrips) { number in
						Color.white
						color.frame(width: lineWidth)
						if number == numberOfStrips - 1 {
							Color.white
						}
					}
				}.mask(TriangleShape())
				.overlay(TriangleShape().stroke(color, lineWidth: borderLineWidth))
			}
		}
	}
}

struct TriangleShape: Shape {
	func path(in rect: CGRect) -> Path {
		let firstThirdMaxX = CGFloat(rect.maxX / 2)
		let firstThirdMaxY = CGFloat(rect.maxY)
		let startDrawPoint = CGPoint(x: firstThirdMaxX, y: firstThirdMaxY / 6)
		return drawOneTriangle(startPoint: startDrawPoint)
	}
	
	private func drawOneTriangle(startPoint: CGPoint, offset: CGFloat = 0) -> Path {
		var path = Path()
		let maxX = startPoint.x
		let maxY = startPoint.y
		let startPoint = CGPoint(x: startPoint.x, y: startPoint.y + offset)
		
		path.move(to: startPoint)											// start drawing point
		path.addLine(to: CGPoint(x: maxX / 4, y: 5 * maxY + offset))		// left bot
		path.addLine(to: CGPoint(x: 7 * maxX / 4, y: 5 * maxY + offset))	// right bot
		path.addLine(to: startPoint)										// top
		return path
	}
}
