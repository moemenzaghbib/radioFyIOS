


import AVFoundation
import SwiftUI
struct SongRow: View {
    let song: Song

    var body: some View {
        HStack {
            Text(song.title)
            Spacer()
            Text(song.artist)
        }
    }
}

struct SongListView: View {
    let songs: [Song]
    @Binding var selectedSong: Song?

    var body: some View {
        List(songs) { song in
            Button(action: {
                selectedSong = song
            }) {
                SongRow(song: song)
            }
        }
    }
}

struct PlayerView1: View {
    @Binding var selectedSong: Song?

    var body: some View {
        VStack(spacing: 20) {
            if let song = selectedSong {
                Text(song.title)
                Text(song.artist)
                Image(song.albumArt)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No song selected")
            }
        }
    }
}

struct MusicPlayerView: View {
    let songs = [
        Song(title: "Song 1", artist: "Artist 1", albumArt: "album-art-1"),
        Song(title: "Song 2", artist: "Artist 2", albumArt: "album-art-2"),
        Song(title: "Song 3", artist: "Artist 3", albumArt: "album-art-3")
    ]
    @State var selectedSong: Song?

    var body: some View {
        NavigationView {
            TabView {
                SongListView(songs: songs, selectedSong: $selectedSong)
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Songs")
                    }
                Text("Playlists")
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Playlists")
                    }
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .navigationTitle("My Music Player")
            .navigationBarTitleDisplayMode(.inline)
            PlayerView(selectedSong: $selectedSong)
                .frame(height: 100)
        }
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
    }
}
