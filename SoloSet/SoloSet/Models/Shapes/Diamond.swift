//
//  Diamond.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct Diamond: ShapeProtocol, View {
	
	var shapeType: ShapeType
	var shading: Shading
	var color: Color
	var shapeCount: Int
	var numberOfStrips: Int = 5
	var lineWidth: CGFloat = 3
	var borderLineWidth: CGFloat = 3
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .diamond
		self.shading = shading
		self.color = color
		self.shapeCount = shapeCount
	}
	
	var body: some View {
		VStack {
			ForEach(0..<shapeCount, id:\.self) { index in
				HStack(spacing: 0) {
					switch shading {
					case .solid:
						color
					case .striped:
						ForEach(0..<numberOfStrips) { number in
							Color.white
							color.frame(width: lineWidth)
							if number == numberOfStrips - 1 {
								Color.white
							}
						}
					case .open:
						Color.white
					}
				}
				.mask(DiamondShape())
				.overlay(DiamondShape().stroke(color, lineWidth: borderLineWidth))
			}
		}
	}
}

struct DiamondShape: Shape {
	func path(in rect: CGRect) -> Path {
		let firstThirdMaxX = CGFloat(rect.maxX / 2)
		let firstThirdMaxY = CGFloat(rect.maxY)
		let startDrawPoint = CGPoint(x: firstThirdMaxX, y: firstThirdMaxY / 6)
		return drawOneDiamond(startPoint: startDrawPoint)
	}

	private func drawOneDiamond(startPoint: CGPoint, offset: CGFloat = 0) -> Path {
		var path = Path()
		let maxX = startPoint.x
		let maxY = startPoint.y
		let startPoint = CGPoint(x: startPoint.x, y: startPoint.y + offset)
		
		path.move(to: startPoint)			// start drawing point
		path.addLine(to: CGPoint(x: 1 * maxX / 4, y: 3 * maxY + offset))		// left
		path.addLine(to: CGPoint(x: maxX, y: 5 * maxY + offset))		// bot
		path.addLine(to: CGPoint(x: 7 * maxX / 4, y: 3 * maxY + offset))		// right
		path.addLine(to: startPoint)		// top
		return path
	}
}
