//
//  PlayerViewModel.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/5/2023.
//

import Foundation

import SwiftUI

/// class defining mainView and player view variables
class PlayerViewModel: ObservableObject {
    @Published var showPlayer = false
    @Published var offset: CGFloat = 0
    @Published var expandPlayer = true
    @Published var song: Song?
    @Published var tabHeight: CGFloat = 60
}
