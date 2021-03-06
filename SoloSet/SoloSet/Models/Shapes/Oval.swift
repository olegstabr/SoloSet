//
//  Oval.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct Oval: ShapeProtocol, View {
	var shapeType: ShapeType
	var shading: Shading
	var color: Color
	var shapeCount: Int
	var numberOfStrips: Int = 5
	var lineWidth: CGFloat = 3
	var borderLineWidth: CGFloat = 3
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .oval
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
						drawStrips(numberOfStrips: numberOfStrips)
					case .open:
						Color.white
					}
				}
				.mask(OvalShape())
				.overlay(OvalShape().stroke(color, lineWidth: borderLineWidth))
			}
		}
		.padding(10)
	}
	
	@ViewBuilder
	private func drawStrips(numberOfStrips: Int) -> some View {
		ForEach(0..<numberOfStrips, id: \.self) { number in
			Color.white
			color.frame(width: lineWidth)
			if number == numberOfStrips - 1 {
				Color.white
			}
		}
	}
}

struct OvalShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.addEllipse(in: rect)
		return path
	}
}
