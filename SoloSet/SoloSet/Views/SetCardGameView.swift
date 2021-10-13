//
//  SetCardGameView.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct SetCardGameView: View {
	@ObservedObject var setCardGame: SetCardGame
    var body: some View {
		NavigationView {
			VStack {
				AspectVGrid(items: setCardGame.cards, aspectRatio: 2/3) { card in
					cardView(for: card)
				}
				.foregroundColor(.red)
			}
			.padding(.horizontal)
			.font(.largeTitle)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button(action: {
						setCardGame.addThreeCards()
					}, label: {
						Image(systemName: "plus.circle")
							.font(.title)
					})
				}
				
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						setCardGame.newGame()
					}, label: {
						Image(systemName: "arrow.clockwise.circle")
							.font(.title)
					})
				}
			}
		}
    }
	
	@ViewBuilder
	private func cardView(for card: SetCardGame.Card) -> some View {
		CardView(card)
			.padding(4)
			.onTapGesture {
				setCardGame.choose(card)
			}
	}
}

struct CardView: View {
	private let card: SetCardGame.Card
	
	init(_ card: SetCardGame.Card) {
		self.card = card
	}
	
	var body: some View {
		GeometryReader(content: { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
				let shapeShading = card.shape.shading
				let shapeType = card.shape.shapeType
				let shapeColor = card.shape.color
				let shapeCount = card.shape.shapeCount
					
				if card.isSelect {
					shape.opacity(0.3)
					shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					Text("\(card.id + 1)").font(font(in: geometry.size))
				} else {
					shape.fill().foregroundColor(.white)
					shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					
					switch shapeType {
					case ShapeType.oval:
						Oval(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					case ShapeType.triangle:
						Triangle(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					case ShapeType.diamond:
						Diamond(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					}
					
//					Text("\(card.id + 1)")
//						.font(font(in: geometry.size))
//						.foregroundColor(.red)
				}
				
				if card.isMatch {
					shape.opacity(1)
				}
			}
		})
	}
	
	private func font(in size: CGSize) -> Font {
		.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
	}

	 private struct DrawingConstants {
		static let cornerRadius: CGFloat = 10
		static let lineWidth: CGFloat = 4
		static let fontScale: CGFloat = 0.6
		static let insideCardCirclePadding: CGFloat = 5
		static let insideCardCircleOpacity: Double = 0.5
	}
}

struct SetCardGameView_Previews: PreviewProvider {
    static var previews: some View {
		let game = SetCardGame()
        SetCardGameView(setCardGame: game)
    }
}
