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
    
    var body: some View {
        VStack {
            List(fetcher.radios) { radio in
                HStack (alignment: .center,
                        spacing: 10) {
                    KFImage(URL(string: radio.imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                    Text(radio.name)
                }.onTapGesture {
                    do {
                        radioPlayer.initPlayer(url: radio.streamUrl)
                        radioPlayer.play(radio)
                    } catch {
                        print("AVAudioPlayer init failed")
                    }
                }
            }
            .frame(height: 500) // Set a fixed height for the list
        }
    }
}

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
