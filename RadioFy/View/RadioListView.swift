//
//  RadioListView.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation
import SwiftUI
import Kingfisher
import AVKit
//
//struct RadioListView: View {
//    @ObservedObject var fetcher = RadioFetcher()
//    @StateObject var radioPlayer = RadioPlayer.instance
//
//    var body: some View {
//        List(fetcher.radios) { radio in
//            HStack (alignment: .center,
//                    spacing: 10) {
//                KFImage(URL(string: radio.imageUrl))
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                Text(radio.name)
//            }.onTapGesture {
//                do {
//                    radioPlayer.initPlayer(url: radio.streamUrl)
//                    radioPlayer.play(radio)
//                } catch {
//                    print("AVAudioPlayer init failed")
//                }
//            }
//        }
//    }
//
//}



struct RadioListView: View {
    @ObservedObject var fetcher = RadioFetcher()
    @StateObject var radioPlayer = RadioPlayer.instance
    let socketURL = URL(string: "http://127.0.0.1:3000")!

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) { // Set spacing to 0
                ChatView(webSocketManager: WebSocketManager(socketURL: socketURL), userName: "YourUserName", roomName: "RoomName")
                    .frame(height: geometry.size.height * 0.5) // Set height to 50% of the screen height
            
                RadioList(fetcher: fetcher)
                    .frame(height: geometry.size.height * 0.5) // Set height to 50% of the screen height
                
                }
        }
    }
}


struct RadioList: View {
    @ObservedObject var fetcher: RadioFetcher
    @StateObject var radioPlayer = RadioPlayer.instance

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(fetcher.radios) { radio in
                    VStack {
//                        KFImage(URL(string: radio.imageUrl))
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 50, height: 50)
//                            .cornerRadius(8) // Add corner radius to make it a small block shape
                        Text(radio.name)
                            .frame(maxWidth: .infinity) // Expand the text to fill the width
                            .padding(.vertical, 8) // Add vertical padding for spacing
                            .background(Color.gray.opacity(0.2)) // Add a background color
                            .cornerRadius(8) // Add corner radius to the text view
                            .onTapGesture {
                                do {
                                    radioPlayer.initPlayer(url: radio.streamUrl)
                                    radioPlayer.play(radio)
                                } catch {
                                    print("AVAudioPlayer init failed")
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width) // Set the width of each item to the screen width
                }
            }
            .padding()
        }
    }
}

//struct RadioList: View {
//    @ObservedObject var fetcher: RadioFetcher
//    @StateObject var radioPlayer = RadioPlayer.instance
//
//    var body: some View {
//        List(fetcher.radios) { radio in
//            HStack(alignment: .center, spacing: 10) {
//                KFImage(URL(string: radio.imageUrl))
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .cornerRadius(8) // Add corner radius to make it a small block shape
//                Text(radio.name)
//            }
//            .frame(maxWidth: .infinity) // Expand the HStack to full width
//            .padding(.vertical, 8) // Add vertical padding for spacing
//            .background(Color.gray.opacity(0.2)) // Add a background color
//            .cornerRadius(8) // Add corner radius to the entire item
//            .onTapGesture {
//                do {
//                    radioPlayer.initPlayer(url: radio.streamUrl)
//                    radioPlayer.play(radio)
//                } catch {
//                    print("AVAudioPlayer init failed")
//                }
//            }
//        }
//    }
//}

//struct RadioList: View {
//    @ObservedObject var fetcher: RadioFetcher
//    @StateObject var radioPlayer = RadioPlayer.instance
//
//    var body: some View {
//        List(fetcher.radios) { radio in
//            HStack(alignment: .center, spacing: 10) {
//                KFImage(URL(string: radio.imageUrl))
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                Text(radio.name)
//            }
//            .onTapGesture {
//                do {
//                    radioPlayer.initPlayer(url: radio.streamUrl)
//                    radioPlayer.play(radio)
//                } catch {
//                    print("AVAudioPlayer init failed")
//                }
//            }
//        }
//    }
//}




//struct RadioListView: View {
//    @ObservedObject var fetcher = RadioFetcher()
//    @StateObject var radioPlayer = RadioPlayer.instance
//
//    var body: some View {
//        VStack {
//            List(fetcher.radios) { radio in
//                HStack (alignment: .center,
//                        spacing: 10) {
//                    KFImage(URL(string: radio.imageUrl))
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 50, height: 50)
//                    Text(radio.name)
//                }.onTapGesture {
//                    do {
//                        radioPlayer.initPlayer(url: radio.streamUrl)
//                        radioPlayer.play(radio)
//                    } catch {
//                        print("AVAudioPlayer init failed")
//                    }
//                }
//            }
//            .frame(height: 500) // Set a fixed height for the list
//        }
//    }
//}

public class RadioFetcher: ObservableObject {
    
    @Published var radios = [RadioModel]()
    
    init(){
        load()
    }
    
    func load() {
//        let url = URL(string: "https://mocki.io/v1/bac7da7a-8d77-413d-a3cf-abeb53c411fc")
        let url = URL(string: "https://raw.githubusercontent.com/moemenzaghbib/radioFyIOS/main/TunsianRadiosList.json")

        URLSession.shared.dataTask(with: url!) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([RadioModel].self, from: d)
                    DispatchQueue.main.async {
                        self.radios = decodedLists
                    }
                } else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
        
    }
    
}

