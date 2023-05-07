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
        NavigationView {
            ZStack {
                RadioListView()
                InfoPanelView()
            }.navigationBarTitle("Radio Player")
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
