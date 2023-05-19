//
//  changePasswordView.swift
//  RadioFy
//
//  Created by imen ben fredj on 19/5/2023.
//


import Foundation
import SwiftUI

struct changePasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAlert = false

    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    func editProfileBack() {
        print("The text was clicked!",firstName)

        let url = URL(string: "http://localhost:9090/user/restorpassword")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // var userData = ["login": "", "password":"", "Age": ""]

    //    let login = userData["login"]
    //    let password = userData["password"]
    //    let Age = userData["Age"]
        let userData: [String: Any] = [
            "email": email,
            "password": password
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
                DispatchQueue.main.async {
                                   presentationMode.wrappedValue.dismiss()
                               }
                showAlert = true

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
                
                Text("Change Password")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                 
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
                    editProfileBack()
                    
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
        } .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("User Profile Updated successfully"),
                dismissButton: .default(Text("OK")) {
                    // Dismiss the current view and go back to the previous view
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
struct changePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        changePasswordView()
    }
}
