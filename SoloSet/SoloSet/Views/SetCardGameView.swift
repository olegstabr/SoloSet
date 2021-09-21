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
		LazyVGrid(columns: [GridItem(.fixed(65))], spacing: 0) {
			ForEach(setCardGame.cards()) { item in
				Text("\(item.id)")
				Spacer()
			}
		}
    }
}

struct SetCardGameView_Previews: PreviewProvider {
    static var previews: some View {
		let game = SetCardGame()
        SetCardGameView(setCardGame: game)
    }
}
