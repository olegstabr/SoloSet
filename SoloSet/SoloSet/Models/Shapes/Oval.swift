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
	
	init(shading: Shading, color: Color) {
		shapeType = .oval
		self.shading = shading
		self.color = color
	}
	
	var body: some View {
		VStack {
			Capsule()
				.frame(width: 100, height: 50)
		}
	}
}
