//
//  NowPlayingView.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation
import SwiftUI
import Kingfisher
struct NowPlayingView: View {
    @StateObject var radioPlayer = RadioPlayer.instance
    @State var stationName = "Not Playing!"
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            HStack(spacing: 8) {
                if radioPlayer.isPlaying || radioPlayer.currentRadio?.name != nil {
                    KFImage(URL(string: radioPlayer.currentRadio!.imageUrl))
                        .resizable()
                        .foregroundColor(Color.secondary)
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                } else {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .overlay(
                            Image(systemName: "music.note")
                                .foregroundColor(Color.secondary)
                                .font(.system(size: 24))
                        )
                }
                
                Text(radioPlayer.currentRadio?.name ?? "Not Playing")
                    .font(.caption)
                    .lineLimit(1)
                
                Spacer()
                
                if radioPlayer.isPlaying {
                    Button(action: {
                        print("stop")
                        radioPlayer.stop()
                    }) {
                        Image(systemName: "stop.fill")
                            .renderingMode(.original)
                            .font(.system(size: 24, weight: .regular))
                    }
                } else if radioPlayer.currentRadio?.name != nil {
                    Button(action: {
                        print("play")
                        radioPlayer.play(radioPlayer.currentRadio!)
                    }) {
                        Image(systemName: "play.fill")
                            .renderingMode(.original)
                            .font(.system(size: 24, weight: .regular))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .shadow(radius: 2)
        }
        .padding(.bottom, 12)
    }
}

//struct NowPlayingView: View {
//    @StateObject var radioPlayer = RadioPlayer.instance
//    @State var stationName = "Not Playing!"
//
//    var body: some View {
//        HStack() {
//            Spacer()
//            ZStack {
//                if radioPlayer.isPlaying || radioPlayer.currentRadio?.name != nil {
//                    KFImage(URL(string: radioPlayer.currentRadio!.imageUrl))
//                        .resizable()
//                        .foregroundColor(Color.secondary)
//                        .frame(width: 100, height: 100)
//                } else {
//                    Rectangle()
//                        .fill(Color.primary)
//                        .frame(width: 100, height: 100)
//                        .cornerRadius(5)
//                        .shadow(radius: 5)
//                    Image(systemName: "music.note")
//                        .foregroundColor(Color.secondary)
//                        .colorInvert()
//                }
//            }
//            Text(radioPlayer.currentRadio?.name ?? "Not Playing")
//                .padding(10)
//            Spacer()
//            if radioPlayer.isPlaying {
//                Button(action: {
//                    print("stop")
//                    radioPlayer.stop()
//                }) {
//                    Image(systemName: "stop.fill")
//                        .renderingMode(.original)
//                        .font(.system(size: 24, weight: .regular))
//                }
//            } else if radioPlayer.currentRadio?.name != nil {
//                Button(action: {
//                    print("play")
//                    radioPlayer.play(radioPlayer.currentRadio!)
//                }) {
//                    Image(systemName: "play.fill")
//                        .renderingMode(.original)
//                        .font(.system(size: 24, weight: .regular))
//                }
//            }
//            Spacer()
//        }.padding(.bottom, 12)
//    }
//
//}
//
struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
