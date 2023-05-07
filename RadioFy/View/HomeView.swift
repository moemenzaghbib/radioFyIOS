//
//  HomeView.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/5/2023.
//

import Foundation


import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: SongViewModel = SongViewModel()
    @EnvironmentObject var player: PlayerViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.songs) { song in
                        SongRowView(song: song)
                            .onTapGesture {
                                withAnimation {
                                    player.showPlayer = true
                                    player.song = song
                                }
                            }
                    }
                }
                .padding(.horizontal, 20.0)
            }
            .onAppear() {
                viewModel.fetchSongs()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
