import SwiftUI
import Kingfisher

struct Comment: Identifiable {
    let id = UUID()
    let user: String
    let profilePicture: Image
    let comment: String
}

struct ItemCardView: View {
    
    @State var title: String?
    @State var image: String?
    @State var description: String?
    @State var date: String?
    @State var link: String?
    @State private var isFilled = false
    @State private var likePostResponse1: String?
    @State private var comments: [Comment] = []
    @State private var showEmptyCommentMessage = false

    @State private var postResponse: String?

    @State private var newComment: String = ""
    
    
    
    var body: some View {
        
        VStack{
        VStack(alignment: .leading, spacing: 10) {
            Text(title ?? "title default")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            KFImage(URL(string: image ?? "test url"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            Spacer()

            Button(action: {
                let session3 = URLSession(configuration: .default)
                let session4 = URLSession(configuration: .default)

                if(isFilled){
                    let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
                    
                    // Retrieve the username from the database using the current email stored in the userdata
                    //            let email = userData.email
                    
                    // TODO: Replace this with your code to retrieve the username from the database
                    let url = URL(string: "http://127.0.0.1:9090/post/RemoveLikePost")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "PUT"
                    let params = ["email": savedEmail, "title": title]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    session4.dataTask(with: request) { data, response, error in
                        if let data = data {
                            if var likePostResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                
                                likePostResponse1 = "Success"
                                self.isFilled.toggle()

                            } else {
                                likePostResponse1 = "Error: unable to parse response remove like"
                            }
                        } else {
                            likePostResponse1 = "Error: \(error?.localizedDescription ?? "Unknown error")"
                        }
                        
                    }.resume()
                }else {
                    let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
                    
                    // Retrieve the username from the database using the current email stored in the userdata
                    //            let email = userData.email
                    
                    // TODO: Replace this with your code to retrieve the username from the database
                    let url = URL(string: "http://127.0.0.1:9090/post/AddLikePost")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "PUT"
                    let params = ["email": savedEmail, "title": title]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    session3.dataTask(with: request) { data, response, error in
                        if let data = data {
                            if var likePostResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                
                                likePostResponse1 = "Success"
                                self.isFilled.toggle()

                            } else {
                                likePostResponse1 = "Error: unable to parse response add like "
                            }
                        } else {
                            likePostResponse1 = "Error: \(error?.localizedDescription ?? "Unknown error")"
                        }
                        
                    }.resume()
                }
                
                
                }) {
                      Image(systemName: isFilled ? "heart.fill" : "heart")
                          .foregroundColor(isFilled ? .red : .gray)
                  }
            
                  .padding(.trailing) // Add some trailing padding

            Text(description ?? "default description")
                .font(.headline)
                .foregroundColor(.black)
            ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(comments) { comment in
                            HStack(alignment: .top) {
                                comment.profilePicture
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(comment.user)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(comment.comment)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
//            ScrollView(.vertical) {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(comments) { comment in
//                        HStack(alignment: .top) {
//                            comment.profilePicture
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
//
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text(comment.user)
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                Text(comment.comment)
//                                    .font(.subheadline)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                        .padding(10)
//                        .background(Color.gray.opacity(0.2))
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//
//                    VStack(alignment: .leading, spacing: 5) {
//
//
//                    }
//                    .padding(10)
//
//
//                }
//            }
            VStack{
                
                Text("Add a comment")
                       .font(.headline)
                       .foregroundColor(.black)
                HStack {
                       TextEditor(text: $newComment)
                           .frame(height: 40)
                           .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(Color.orange, lineWidth: 2)
                               )
                           .background(Color.gray.opacity(0.9))
                           .clipShape(RoundedRectangle(cornerRadius: 10))
                           .padding(.leading, 10)
                       Button(action: {
                           if newComment.isEmpty {
                                          showEmptyCommentMessage = true
                           } else {
                               let session00 = URLSession(configuration: .default)
                               let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
                               let url11 = URL(string: "http://127.0.0.1:9090/post/addComment")!
                               var request11 = URLRequest(url: url11)
                               request11.httpMethod = "POST"
                               let params = ["title": title,"email": savedEmail,"content": newComment]
                               request11.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                               request11.addValue("application/json", forHTTPHeaderField: "Content-Type")
                               
                               
                               session00.dataTask(with: request11) { data, response, error in
                                   if let data = data {
                                       
                                       if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                           newComment = ""
                                           postResponse = "hamma ahkilna chaamlt fil ajout cmntr"
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                   self.populateScrollView()
                                               }
                                           
                                       } else {
                                           postResponse = "Error: unable to parse response fama mochkla fil comments ya hamma ejri "
                                       }
                                   } else {
                                       postResponse = "Error: \(error?.localizedDescription ?? "Unknown error")"
                                   }
                               }.resume()
                               
                           }
                        
                       
                           }) {
                               Image(systemName: "paperplane.fill")
                                   .resizable()
                                   .scaledToFit()
                                   .foregroundColor(.black)
                                   .frame(width: 20, height: 20)
                                   .padding(.trailing, 10)
                           }
                       if showEmptyCommentMessage {
                               Text("Please enter a comment")
                                   .foregroundColor(.red)
                           }
                   }

            }
           
            Spacer()
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.black)

                Text(date ?? "default date")
                    .foregroundColor(.black)
                    .font(.footnote)
                
                Spacer()
                
                Button(action: {
                    // take user to the link
                    if let linkString = link, let url = URL(string: linkString) {
                        UIApplication.shared.open(url)
                    }                }) {
                    Text("View post on web")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            Spacer()
            
        }
//        .background(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear {
            let session1 = URLSession(configuration: .default)
                      let session2 = URLSession(configuration: .default)
            let url = URL(string: "http://127.0.0.1:9090/post/GetOnePost")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let params = ["title": title]
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            session1.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let title1 = jsonResponse["title"] as? String {
                            print(title1)
                            title = title1
                        }
                        if let image1 = jsonResponse["image"] as? String {
                            print(image1)

                            image = image1
                        }
                        if let description1 = jsonResponse["desc"] as? String {
                            print(description1)

                            description = description1
                        }
                        if let link1 = jsonResponse["url"] as? String {
                            print(link1)

                            link = link1
                        }
                        if let date1 = jsonResponse["date"] as? String {
                            print(date1)

                            date = date1
                        }
                        postResponse = "Success"
                    } else {
                        postResponse = "Error: unable to parse response"
                    }
                } else {
                    postResponse = "Error: \(error?.localizedDescription ?? "Unknown error")"
                }
            }.resume()
            

            let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
            
            let url1 = URL(string: "http://127.0.0.1:9090/user/checkLikeUser")!
            var request1 = URLRequest(url: url1)
            request1.httpMethod = "POST"
            let params1 = ["email": savedEmail, "title": title]
            request1.httpBody = try? JSONSerialization.data(withJSONObject: params1, options: [])
            request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
            session2.dataTask(with: request1) { data, response, error in
                

                if let data = data {
                 
                    if var likePostResponse11 = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let likePostResult = likePostResponse11["value"] as? String {
                            if (likePostResult == "true"){
                                self.isFilled.toggle()
                            }
                        }
                        likePostResponse1 = "Success"
                        
                    } else {
                        likePostResponse1 = "Error: unable to parse response"
                    }
                } else {
                    likePostResponse1 = "Error: \(error?.localizedDescription ?? "Unknown error")"
                }
                
               
            
            }.resume()
            populateScrollView()

        }
      
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .cornerRadius(10)
        .padding()
        
}
    
    func populateScrollView() {
        let newComments: [Comment] = []
        // Clear the comments array
        comments.removeAll()

        let session2 = URLSession(configuration: .default)
        let url = URL(string: "http://127.0.0.1:9090/post/allcomments")!
        var request = URLRequest(url: url)
                request.httpMethod = "POST"
        let params = ["title": title]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")


                session2.dataTask(with: request) { data, response, error in
                  if let data = data {
                      if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {

                          for jsonDict in jsonResponse {
                                          // Handle each JSON dictionary object in the array
                                          if let key = jsonDict["key"] as? String, let value = jsonDict["value"] as? String {
                                              comments.append(Comment(user: key, profilePicture: Image(systemName: "person.crop.circle.fill"), comment: value))
                                          }
                                      }
                          postResponse = "Success"
                      } else {
                          postResponse = "Error: unable to parse response"
                      }
                  } else {
                      postResponse = "Error: \(error?.localizedDescription ?? "Unknown error")"
                  }
                }.resume()
        // Populate the comments array with new comments
//         newComments = [
//            Comment(user: "John", profilePicture: Image(systemName: "paperplane.fill"), comment: "This is a new comment!"),
//            Comment(user: "Jane", profilePicture: Image(systemName: "paperplane.fill"),  comment: "Another new comment!"),
//            Comment(user: "Bob", profilePicture: Image(systemName: "paperplane.fill"), comment: "A third new comment!"),
//        ]
//        comments.append(contentsOf: newComments)
    }
    
    
}


struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(
            title: "Sample Item"
          
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
