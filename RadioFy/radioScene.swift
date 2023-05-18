//
//  radioScene.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation
import SwiftUI

    
    struct radioScene: View {
        var body: some View {
                VStack {
                    // Fix the size and position of RadioListView
                    RadioListView()
//                        .frame(height: 880)
                        .offset(x: 0, y: 220) // Adjust the offset as needed
                    // Add InfoPanelView on top of it
                    InfoPanelView()
                        .zIndex(1)
                        .padding(.bottom, 10) // Add bottom padding
                }
            

        }
    }


struct radioScene_Previews: PreviewProvider {
    static var previews: some View {
        radioScene()
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemChromeMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
