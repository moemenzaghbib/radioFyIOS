//
//  ContentView.swift
//  Local Media
//
//  Created by Robert Sandru on 5/9/20.
//  Copyright © 2020 codecontrive. All rights reserved.
//

import SwiftUI

struct ContentView123: View {
    
    @EnvironmentObject var store: Store
    
    @State private var sheetShown = false
    
    var body: some View {
        TabView {
            TracksScreenView().tabItem {
                Image(systemName: "music.note.list")
                Text("Tracks")
            }
            HomeScreenView().tabItem {
                Image(systemName: "list.dash")
                Text("Playlists")
            }
            Text("Profile").tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            Text("Settings").tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .accentColor(Color(Colors.primary.get()))
    }
}

struct ContentView123_Previews: PreviewProvider {
    static var previews: some View {
        ContentView123().environmentObject(Store()).environment(\.colorScheme, .dark)
    }
}
