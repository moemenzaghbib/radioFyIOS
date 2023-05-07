import SwiftUI
import AVFoundation

class Song: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }

    static func == (lhs: Song, rhs: Song) -> Bool {
        lhs.id == rhs.id
    }
}

class MusicPlayer: ObservableObject {
    var player: AVPlayer?
    var currentItem: AVPlayerItem?
    @Published var isPlaying: Bool = false
    @Published var currentSong: Song?
    @Published var currentIndex: Int = 0
    @Published var songs: [Song] = []

    func playSong(_ song: Song) {
        guard let index = songs.firstIndex(of: song) else { return }
        currentIndex = index
        currentSong = song
        currentItem = AVPlayerItem(url: song.url)
        player = AVPlayer(playerItem: currentItem)
        player?.play()
        isPlaying = true
    }

    func pauseSong() {
        player?.pause()
        isPlaying = false
    }

    func togglePlayPause() {
        if isPlaying {
            pauseSong()
        } else if let song = currentSong {
            playSong(song)
        }
    }

    func playNextSong() {
        guard !songs.isEmpty else { return }
        currentIndex = (currentIndex + 1) % songs.count
        let nextSong = songs[currentIndex]
        playSong(nextSong)
    }

    func playPreviousSong() {
        guard !songs.isEmpty else { return }
        currentIndex = (currentIndex - 1 + songs.count) % songs.count
        let previousSong = songs[currentIndex]
        playSong(previousSong)
    }
    
    func addSongs(_ urls: [URL]) {
        let newSongs = urls.map({ Song(name: $0.lastPathComponent, url: $0) })
        songs.append(contentsOf: newSongs)
    }
}
struct MusicPlayerView: View {
    @StateObject var musicPlayer = MusicPlayer()
    @State var isImporting: Bool = false
    @State var songs: [Song] = []

    var body: some View {
        VStack {
            if !musicPlayer.isPlaying {
                Button(action: {
                    isImporting = true
                }, label: {
                    Text("Import Songs")
                })
                .padding()
            }

            List(musicPlayer.songs) { song in
                Button(action: {
                    musicPlayer.playSong(song)
                }, label: {
                    Text(song.name)
                })
            }

            HStack {
                Button(action: {
                    musicPlayer.pauseSong()
                }, label: {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 30))
                })
                .padding()

                Button(action: {
                    musicPlayer.togglePlayPause()
                }, label: {
                    Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                })
                .padding()

                Button(action: {
                    musicPlayer.playNextSong()
                }, label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 30))
                })
                .padding()
            }
        }
        .sheet(isPresented: $isImporting) {
            DocumentPicker(supportedTypes: ["public.audio"], onUrlsPicked: { urls in
                let newSongs = urls.map({ Song(name: $0.lastPathComponent, url: $0) })
                musicPlayer.songs.append(contentsOf: newSongs)
                songs = musicPlayer.songs
                isImporting = false
            })
        }
        .onAppear {
            AVPlayer.setupObservers()
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIDocumentPickerViewController

    let supportedTypes: [String]
    let onUrlsPicked: ([URL]) -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.onUrlsPicked(urls)
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
}

extension AVPlayer {
    static func setupObservers() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
}

//import SwiftUI
//import AVFoundation
//
//struct Song: Identifiable {
//    let id = UUID()
//    let name: String
//    let url: URL
//}
//
//class MusicPlayer: ObservableObject {
//    var player: AVPlayer?
//    var currentItem: AVPlayerItem?
//    @Published var isPlaying: Bool = false
//    @Published var currentSong: Song?
//
//    func playSong(_ song: Song) {
//        currentSong = song
//        currentItem = AVPlayerItem(url: song.url)
//        player = AVPlayer(playerItem: currentItem)
//        player?.play()
//        isPlaying = true
//    }
//
//    func pauseSong() {
//        player?.pause()
//        isPlaying = false
//    }
//
//    func togglePlayPause() {
//        if isPlaying {
//            pauseSong()
//        } else if let song = currentSong {
//            playSong(song)
//        }
//    }
//}
//
//struct MusicPlayerView: View {
//    @StateObject var musicPlayer = MusicPlayer()
//    @State var isImporting: Bool = false
//    @State var songs: [Song] = []
//
//    var body: some View {
//        VStack {
//            if !musicPlayer.isPlaying {
//                Button(action: {
//                    isImporting = true
//                }, label: {
//                    Text("Import Songs")
//                })
//                .padding()
//            }
//
//            List(songs) { song in
//                Button(action: {
//                    musicPlayer.playSong(song)
//                }, label: {
//                    Text(song.name)
//                })
//            }
//
//            if musicPlayer.isPlaying {
//                Button(action: {
//                    musicPlayer.pauseSong()
//                }, label: {
//                    Text("Pause")
//                })
//                .padding()
//            }
//        }
//        .sheet(isPresented: $isImporting) {
//            DocumentPicker(supportedTypes: ["public.audio"], onUrlsPicked: { urls in
//                songs.append(contentsOf: urls.map({ Song(name: $0.lastPathComponent, url: $0) }))
//                isImporting = false
//            })
//        }
//        .onAppear {
//            AVPlayer.setupObservers()
//        }
//    }
//}
//
//struct DocumentPicker: UIViewControllerRepresentable {
//    typealias UIViewControllerType = UIDocumentPickerViewController
//
//    let supportedTypes: [String]
//    let onUrlsPicked: ([URL]) -> Void
//
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let documentPicker = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
//        documentPicker.allowsMultipleSelection = true
//        documentPicker.delegate = context.coordinator
//        return documentPicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        let parent: DocumentPicker
//
//        init(_ parent: DocumentPicker) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            parent.onUrlsPicked(urls)
//        }
//    }
//}
//
//extension AVPlayer {
//    static func setupObservers() {
//        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//        try? AVAudioSession.sharedInstance().setActive(true)
//    }
//}
