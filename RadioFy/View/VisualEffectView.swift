//
//  VisualEffectView.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect = UIBlurEffect(style: .systemThinMaterial)
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        VisualEffectView()
    }
}
