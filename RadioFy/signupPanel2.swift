//
//  singupPanel.swift
//  RadioFy
//
//  Created by imen ben fredj on 14/3/2023.
//

import Foundation
import SwiftUI

struct SignUpView2: View {
    
    var firstName: String
       var lastName: String
       var age: String
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var isSuccess = false

    func test() {
        print("The text was clicked!", firstName)

        let url = URL(string: "http://localhost:9090/user/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let userData: [String: Any] = [
            "firstname": firstName,
            "lastname": lastName,
            "Age": age,
            "email": email,
            "password": password,
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: userData)

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if response.statusCode == 200 {
                print("User signed up successfully")

                DispatchQueue.main.async {
                    let popup = UIAlertController(title: "Signup Success", message: "You have successfully signed up!", preferredStyle: .alert)
                    popup.addAction(UIAlertAction(title: "OK", style: .default))
                    UIApplication.shared.windows.first?.rootViewController?.present(popup, animated: true)
                    isSuccess = true
                }

            } else {
                print("Error: \(response.statusCode)")
            }
        }

        task.resume()
    }


    var body: some View {
        VStack {
           
            
            VStack {
            
               
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray) // Set the color of the image to gray
                        .padding(.leading, 8)
                    TextField("Email", text: $email)
                        .padding(.leading, 8)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray, lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(8)
                .padding()
                .shadow(radius: 4)
                ZStack(alignment: .leading) {
                    Image(systemName: "lock")
                        .foregroundColor(.gray) // Set the color of the image to gray
                    SecureField("Password", text: $password)
                        .padding(.leading, 32)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray, lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(8)
                .padding()
                .shadow(radius: 4)
                
                ZStack(alignment: .leading) {
                    Image(systemName: "lock")
                        .foregroundColor(.gray) // Set the color of the image to gray
                        .padding(.leading, 8)
                    SecureField(" Repeat Password", text: $password)
                        .padding(.leading, 32)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray, lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(8)
                .padding()
                .shadow(radius: 4)
                Button(action: {
                    test()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 330 )
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                Button(action: {
                    // Handle login button tap
                }) {
                    Text("Back")
                        .fontWeight(.bold)
                        .frame(width: 300)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color .gray)
                        .cornerRadius(8)
                    
                }
                .padding(.vertical, 10)
            }
            
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .shadow(radius: 4)
            .offset(y: 200)

            Spacer()
        }
       
            .ignoresSafeArea()
        .background( LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
        
        
       
//        .ignoresSafeArea()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

//struct SignupPanel2_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView2().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
