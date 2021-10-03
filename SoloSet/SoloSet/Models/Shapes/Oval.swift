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
	
	init(shading: Shading, color: Color, shapeCount: Int) {
		shapeType = .oval
		self.shading = shading
		self.color = color
		self.shapeCount = shapeCount
	}
	
	var body: some View {
		VStack {
			Capsule()
				.frame(width: 100, height: 50)
		}
	}
}
