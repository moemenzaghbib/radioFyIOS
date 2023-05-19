import SwiftUI
import Foundation
struct ProfilePanel: View {
//    @EnvironmentObject var userData: UserData
    @State var username: String = ""
    @State var lastname: String = ""
    @State private var goingEDIT = false
    @State private var goingChangePassword = false
    @State private var loginResponse: String?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Image("userIcone")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Text(username) // Display the retrieved username
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(lastname)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                
                Spacer()

                VStack {
                    Button(action: {
                        goingEDIT = true
                    }) {
                        Text("Edit Profile")
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 330 )
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(8)
                        
                    }
                    NavigationLink(destination: EditProfileView(), isActive: $goingEDIT) {
                        EmptyView()
                    }
                    Spacer()
                    Button(action: {
                        goingChangePassword = true
                    }) {
                        Text("Change password")
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 330 )
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(8)
                        
                    }
                    NavigationLink(destination: changePasswordView(), isActive: $goingChangePassword) {
                        EmptyView()
                    }
                    Button(action: {
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                          UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: LoginView())
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()View()
                    }) {
                        Text("Logout")
                            .fontWeight(.bold)
                            .frame(width: 300)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color .gray)
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
                
            }
        }
        .onAppear {
            let savedEmail = UserDefaults.standard.string(forKey: "emailLogin")
               let savedPassword = UserDefaults.standard.string(forKey: "passwordLogin")
            // Retrieve the username from the database using the current email stored in the userdata
//            let email = userData.email
            let email = "moemen.zaghbib@esprit.tn"
            let password = "Moemen99"
            // TODO: Replace this with your code to retrieve the username from the database
            let url = URL(string: "http://127.0.0.1:9090/user/signin")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let params = ["email": savedEmail, "password": savedPassword]
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let firstName = jsonResponse["firstname"] as? String {
                            username = firstName
                            let defaults1 = UserDefaults.standard

                            defaults1.set(username, forKey: "lastname")
                        }
                        if let lastName = jsonResponse["lastname"] as? String {
                            lastname = lastName
                            let defaults1 = UserDefaults.standard

                            defaults1.set(lastName, forKey: "lastname")
                        }
                        loginResponse = "Success"
                    } else {
                        loginResponse = "Error: unable to parse response"
                    }
                    print(loginResponse)
                } else {
                    loginResponse = "Error: \(error?.localizedDescription ?? "Unknown error")"
                }
            }.resume()

        }
    }
}

struct ProfilePanel_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePanel()
    }
}
