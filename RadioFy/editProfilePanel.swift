//
//  editProfilePanel.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/4/2023.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    func editProfileBack() {
        print("The text was clicked!",firstName)

        let url = URL(string: "http://localhost:9090/user/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // var userData = ["login": "", "password":"", "Age": ""]

    //    let login = userData["login"]
    //    let password = userData["password"]
    //    let Age = userData["Age"]
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
                print("User Profile Updated successfully")
//                NavigationLink(destination: SignUpView2(firstName: firstName, lastName: lastName, age: age)) {

            } else {
                print("Error: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
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
                
                Text("Edit Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    TextField("Age", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    SecureField("Repeat Password", text: $repeatPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                }
                .padding(.bottom, 30)
                
                Button(action: {
                    // Handle save button tap
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 330 )
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                }
                
                Spacer()
            }
        }
    }
}
struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
