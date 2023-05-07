////
////  postsPanel.swift
////  RadioFy
////
////  Created by imen ben fredj on 16/3/2023.
////

import Foundation

import Kingfisher

import SwiftUI
//import Kingfisher


struct Post: Decodable{
    let _id: String
    let title: String
let author: String
let desc: String
    let image: String
    let url: String
    let date: String
    let likes: Int
    let __v: Int
}


struct PostCard: View {

    let post: Post

    var body: some View {

        VStack {
            
            KFImage(URL(string: post.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .cornerRadius(10)
            
            Text(post.title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(post.desc)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .lineLimit(2)
            
            NavigationLink(destination: ItemCardView(title: post.title)) {
                Text("See More")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
        }
            .padding(.bottom, 10)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

}

struct PostCardList: View {
    @State var posts: [Post] = []
    @State var isLoading = false


    var body: some View {
        
          ScrollView {
              if isLoading {
                  ProgressView()
                      .padding(.vertical, 10)
              } else {
                  LazyVStack(spacing: 10) {
                      ForEach(posts, id: \.title) { post in
                          PostCard(post: post)
                      }
                  }
                  .padding(.vertical, 10)
              }
          }
          .onAppear(perform: fetchPosts)
        
      }

      func fetchPosts() {
          guard let url = URL(string: "http://127.0.0.1:9090/post/scrapeAndSavePosts") else { return }
          
          isLoading = true
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              defer { isLoading = false }
              guard let data = data, error == nil else {
                  print("Error: \(error?.localizedDescription ?? "Unknown error")")
                  return
              }
              
              do {
                  // Decode data into an array of Post objects
                  let decodedData = try JSONDecoder().decode([Post].self, from: data)
                  DispatchQueue.main.async {
                      // Update the posts array with the retrieved data
                      self.posts = decodedData
                  }
              } catch {
                  print("Error decoding data: \(error.localizedDescription)")
              }
          }.resume()
      }
  }


struct POSTSPANEL: View {
    @State var player = PlayerViewModel()

    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                PostCardList()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                    .tag(0)
                
                radioScene()
                    .tabItem {
                        Label("Radio", systemImage: "dot.radiowaves.left.and.right")
                    }
                    .tag(1)
                
                MusicPlayerView()
                                               .navigationTitle("Media List")
                                               .environmentObject(player)                    .tabItem {
                        Label("Music", systemImage: "music.note")
                    }
                    .tag(2)
                
                
                LikedItemsFun()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(3)
                
                
                ProfilePanel()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(4)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                 
                }
            }
        }
    }
}
    struct PostCardList_Previews: PreviewProvider {
        static var previews: some View {
            POSTSPANEL()
        }
    }
