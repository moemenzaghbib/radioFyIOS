//
//  SongViewModel.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/5/2023.
//

import Foundation

/// Class to fetch songs data from local json file
class SongViewModel: ObservableObject {
    
    @Published var songs: [Song] = []
    
    /// function to fetch songs
    func fetchSongs() {
        if let path = Bundle.main.path(forResource: "Songs", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                songs = try JSONDecoder().decode([Song].self, from: data)
            } catch {
                debugPrint(error)
            }
        }
    }
}
