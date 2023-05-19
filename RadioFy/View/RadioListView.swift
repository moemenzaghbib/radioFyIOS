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
struct RadioListView: View {
    @State private var currentRoom: String = "WaitingHALL" // Add a @State property to hold the current room name

    @ObservedObject var fetcher = RadioFetcher()
    @StateObject var radioPlayer = RadioPlayer.instance
    let socketURL = URL(string: "http://127.0.0.1:3000")!
    let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
    var body: some View {
            VStack(spacing: 0) { // Set spacing to 0
                ChatView(webSocketManager: WebSocketManager(socketURL: socketURL), userName: savedEmail!, roomName: $currentRoom)
//                    .frame(maxHeight: .infinity) // Allow ChatView to expand vertically
                RadioList(fetcher: fetcher)
            }
            .padding(.bottom, 10) // Add bottom padding
            .edgesIgnoringSafeArea(.bottom) // Ignore safe area for bottom padding
            .navigationBarTitle("Radio List")
        }

    
}

struct RadioList: View {
    let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")

    @ObservedObject var fetcher: RadioFetcher
    @StateObject var radioPlayer = RadioPlayer.instance
    @State private var selectedRoom: String = "WaitingHALL" // Add a state variable to store the selected room

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack() {
                ForEach(fetcher.radios) { radio in
                    VStack {
                        Text(radio.name)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedRoom = radio.name // Update the selected room
                                do {
                                    radioPlayer.initPlayer(url: radio.streamUrl)
                                    radioPlayer.play(radio)
                                } catch {
                                    print("AVAudioPlayer init failed")
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
        .onChange(of: selectedRoom) { newValue in
            // Rejoin the selected room in the ChatView
            WebSocketManager.shared.joinRoom(roomName: selectedRoom, userName: savedEmail!)
        }
    }
}

//struct RadioList: View {
//    @ObservedObject var fetcher: RadioFetcher
//    @StateObject var radioPlayer = RadioPlayer.instance
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: true) {
//            HStack() {
//                ForEach(fetcher.radios) { radio in
//                    VStack {
////                        KFImage(URL(string: radio.imageUrl))
////                            .resizable()
////                            .aspectRatio(contentMode: .fill)
////                            .frame(width: 50, height: 50)
////                            .cornerRadius(8) // Add corner radius to make it a small block shape
//                        Text(radio.name)
//                            .frame(maxWidth: .infinity) // Expand the text to fill the width
//                            .padding(.vertical, 8) // Add vertical padding for spacing
//                            .background(Color.gray.opacity(0.2)) // Add a background color
//                            .cornerRadius(8) // Add corner radius to the text view
//                            .onTapGesture {
//                                do {
//                                    radioPlayer.initPlayer(url: radio.streamUrl)
//                                    radioPlayer.play(radio)
//                                } catch {
//                                    print("AVAudioPlayer init failed")
//                                }
//                            }
//                    }
//                    .frame(width: UIScreen.main.bounds.width) // Set the width of each item to the screen width
//                }
//            }
////            .padding()
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

