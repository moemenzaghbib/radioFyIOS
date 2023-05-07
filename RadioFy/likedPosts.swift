import SwiftUI
import Kingfisher

struct PostLiked: Decodable{
    let title: String

    let image: String
    
}



struct likedPostStruct: View {
    let item: PostLiked
    var body: some View {
       

        ScrollView {
            LazyVStack {
                NavigationLink(destination: ItemCardView(title: item.title)) {
                        // do something when the button is tapped
                    
                        HStack {
                            KFImage(URL(string: item.image))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                                .clipped()
                            
                            Text(item.title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 3)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                
            }.onAppear(
            )
            .padding()
        }
    }
}
struct LikedItemsFun: View {
    @State var isLoading = false
    
    @State var likedposts22: [PostLiked] = []
    
    
    var body: some View {
        
        ScrollView {
            if isLoading {
                ProgressView()
                    .padding(.vertical, 10)
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(likedposts22, id: \.title) { post in
                        likedPostStruct(item: post)
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .onAppear(perform: fetchPosts)
        
    }
    
    func fetchPosts() {
        let session2 = URLSession(configuration: .default)
        let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
        
        let url = URL(string: "http://127.0.0.1:9090/user/getLikedPosts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = ["email": savedEmail]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        isLoading = true
        
        session2.dataTask(with: request) { data, response, error in
            defer { isLoading = false }
            if let data = data {
       
                    
                    // Decode data into an array of Post objects
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("test 2")
                        DispatchQueue.main.async {
                            for jsonDict in jsonResponse {
                                // Handle each JSON dictionary object in the array
                                if let title1 = jsonDict["title"] as? String, let image1 = jsonDict["image"] as? String {
                                    likedposts22.append(PostLiked(title: title1, image: image1 ))
                                }
                            }
                            
                            
                        }}
              }
            }.resume()
        }
    }

struct likedPosts_Previews: PreviewProvider {
    static var previews: some View {
        LikedItemsFun()
    }
}
