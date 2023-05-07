//
//  SongBackgroundView.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/5/2023.
//

import Foundation
import SwiftUI

/// this view sets background for player view
struct SongBackgroundView: View {
    @Binding var expandPlayer: Bool
    var body: some View {
        if expandPlayer {
            ZStack {
                Image("background")
                    .resizable()
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .secondary, Color(.systemGray4), Color(.systemGray3)]), startPoint: .top, endPoint: .bottom))
            }
        } else {
            Rectangle()
                .foregroundColor(Color(.systemGray3))
        }
    }
}
