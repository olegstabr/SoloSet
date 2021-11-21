//
//  SetCardGameView.swift
//  SoloSet
//
//  Created by Олег Стабровский on 21.09.2021.
//

import SwiftUI

struct SetCardGameView: View {
	@ObservedObject var setCardGame: SetCardGame
	@State private var addCardsResult: Bool = true
	@State private var firstDeckWasClicked: Bool = false
	@State private var dealt = Set<Int>()
	@Namespace private var dealingNamespace
	
    var body: some View {
		NavigationView {
			VStack {
				AspectVGrid(items: setCardGame.cards, aspectRatio: 2/3) { card in
					cardView(for: card)
				}
				.foregroundColor(.red)
				HStack {
					deckBody
					Spacer()
					Text("\(setCardGame.deckCount)")
					Spacer()
					discardPileBody
				}
			}
			.padding(.horizontal)
			.font(.largeTitle)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						withAnimation {
							setCardGame.newGame()
						}
					}, label: {
						Image(systemName: "arrow.clockwise.circle")
							.font(.title)
					})
				}
			}
		}
    }
	
	var discardPileBody: some View {
		ZStack {
			if setCardGame.discardPile.count == 0 {
				let shape = RoundedRectangle(cornerRadius: 10)
				shape
					   .fill()
					   .opacity(0)
				shape.strokeBorder(lineWidth: 4)
			}
			else {
				ForEach(setCardGame.discardPile) { card in
					CardView(card)
//						.matchedGeometryEffect(id: card.id, in: dealingNamespace)
//						.transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
				}
			}
		}
		.frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
		.foregroundColor(.red)
	}
	
	var deckBody: some View {
		ZStack {
			ForEach(setCardGame.deck) { card in
				CardView(card)
					.matchedGeometryEffect(id: card.id, in: dealingNamespace)
					.transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
					.zIndex(zIndex(of: card))
			}
			.frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
			.foregroundColor(.red)
			.onTapGesture {
				var addCardsCount = 12
				
				if !firstDeckWasClicked {
					firstDeckWasClicked.toggle()
				} else {
					addCardsCount = 3
				}
				
				for i in 0..<addCardsCount {
					let card = setCardGame.deck[i]
					
					withAnimation(dealAnimation(for: card)) {
						deal(card)
						setCardGame.addCardFromDeck(card)
					}
				}
			}
		}
	}
	
	@ViewBuilder
	private func cardView(for card: SetCardGame.Card) -> some View {
		if isUndealt(card) {
			Color.clear
		} else {
			CardView(card)
				.matchedGeometryEffect(id: card.id, in: dealingNamespace)
				.transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
				.zIndex(zIndex(of: card))
				.padding(4)
				.onTapGesture {
					withAnimation {
						setCardGame.choose(card)
					}
				}
		}
	}
	
	private func dealAnimation(for card: SetCardGame.Card) -> Animation {
		var delay = 0.0
		if let index = setCardGame.cards.firstIndex(where: { $0.id == card.id }) {
			delay = Double(index) * (CardConstants.totalDealDuration /  Double(setCardGame.cards.count))
		}
		return .easeInOut(duration: CardConstants.dealDuration).delay(delay)
	}
	
	private func deal(_ card: SetCardGame.Card) {
		dealt.insert(card.id)
	}
	
	private func isUndealt(_ card: SetCardGame.Card) -> Bool {
		!dealt.contains(card.id)
	}
	
	private func zIndex (of card: SetCardGame.Card) -> Double {
		-Double(setCardGame.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
	}
	
	private struct CardConstants {
		static let aspectRatio: CGFloat = 2/3
		static let dealDuration: Double = 0.3
		static let totalDealDuration: Double = 3
		static let undealtHeight: CGFloat = 90
		static let undealtWidth = undealtHeight * aspectRatio
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
				
				if (card.isFaceUp) {
					if card.isSelect {
						shape
							.fill()
							.foregroundColor(.red)
							.opacity(0.1)
						shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					} else {
						shape.fill().foregroundColor(.white)
						shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					}
					
					switch shapeType {
					case ShapeType.oval:
						Oval(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					case ShapeType.triangle:
						Triangle(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					case ShapeType.diamond:
						Diamond(shading: shapeShading, color: shapeColor, shapeCount: shapeCount)
					}
				} else {
					shape
						.fill()
						.foregroundColor(.red)
						.opacity(1)
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
