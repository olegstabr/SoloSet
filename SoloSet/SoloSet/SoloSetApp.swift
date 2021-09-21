//
//  SoloSetApp.swift
//  SoloSet
//
//  Created by Олег Стабровский on 20.09.2021.
//

import SwiftUI

@main
struct SoloSetApp: App {
    var body: some Scene {
		let game = SetCardGame()
        WindowGroup {
            SetCardGameView(setCardGame: game)
        }
    }
}
