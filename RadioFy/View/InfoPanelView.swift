//
//  InfoPanelView.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation
import SwiftUI

struct InfoPanelView: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Spacer()
            ZStack {
                VisualEffectView()
                NowPlayingView()
            }.frame(height: 160)
                .padding(.bottom, 10)

        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
    }
}
