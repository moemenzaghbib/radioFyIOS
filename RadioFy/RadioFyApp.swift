//
//  RadioFyApp.swift
//  RadioFy
//
//  Created by imen ben fredj on 9/3/2023.
//

import SwiftUI

@main
struct RadioFyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
