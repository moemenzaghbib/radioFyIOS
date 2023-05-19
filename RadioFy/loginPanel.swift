//
//  loginPanel.swift
//  RadioFy
//
//  Created by imen ben fredj on 9/3/2023.
//



import GoogleSignInSwift

    import Foundation
    import SwiftUI


    import SwiftUI

    struct LoginView: View {
        @State private var showAlert = false

        @State private var isPresentingSignUp = false
        @State private var transition = false
        @State private var loginResponse: String?
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var isShowingSignUpView = false
        @State var isChecked: Bool = false
        @State private var isEmailValid = true
        @State private var isPasswordValid = true
        
        var body: some View {
            NavigationStack {
                
               
                    Image("RadioFyLogo")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding()
                    
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 255/255, green: 194/255, blue: 99/255), Color(red: 255/255, green: 101/255, blue: 70/255)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                        .clipShape(Circle())
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isEmailValid ? Color.clear : Color.red, lineWidth: 2)
                        )
                        .padding(.horizontal)
                    
                    if !isEmailValid {
                        Text("Please enter a valid email")
                            .foregroundColor(.red)
                            .padding(.leading)
                            .transition(.move(edge: .bottom))
                    }
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isPasswordValid ? Color.clear : Color.red, lineWidth: 2)
                        )
                        .padding(.horizontal)
                    
                    if !isPasswordValid {
                        Text("Please enter a valid password")
                            .foregroundColor(.red)
                            .padding(.leading)
                            .transition(.move(edge: .bottom))
                    }
                VStack { Toggle(isOn: $isChecked) {
                    Text("save account on login")
                }
                .padding(.horizontal)

                    Button(action: {
                        isEmailValid = isValidEmail(email)
                        isPasswordValid = isValidPassword(password)
                        
                        if isEmailValid && isPasswordValid {
                            
                            print("test 533253")
                            let url = URL(string: "http://127.0.0.1:9090/user/signin")!
                            var request = URLRequest(url: url)
                            request.httpMethod = "POST"
                            let params = ["email": email, "password": password]
                            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            
                            URLSession.shared.dataTask(with: request) { data, response, error in
                                if let httpResponse = response as? HTTPURLResponse {
                                    if httpResponse.statusCode == 200 {
                                        loginResponse = String(data: data!, encoding: .utf8)
//                                        print(loginResponse)
                                        // Success! The response is 200.
                                        if(isChecked){
                                            let defaults = UserDefaults.standard
                                            defaults.set(email, forKey: "emailLogin")
                                            defaults.set(password, forKey: "passwordLogin")
                                            print("hamma tahan")
                                            if let jsonData = loginResponse!.data(using: .utf8) {
                                                do {
                                                    if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                                        // Use the parsed dictionary here
                                                        print(jsonData)
                                                        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                                            if let firstname = jsonDict["firstname"] as? String, let lastname = jsonDict["lastname"] as? String {
                                                                let defaults1 = UserDefaults.standard

                                                                defaults1.set(jsonDict["lastname"] as? String, forKey: "lastname")
                                                                defaults1.set(jsonDict["firstname"] as? String, forKey: "firstname")
                                                                print("hamma tahan")
                                                                print("First name: \(firstname)")
                                                                print("Last name: \(lastname)")
                                                                defaults1.synchronize()

                                                            } else {
                                                                print("First name or last name not found")
                                                            }
                                                        }
                                                    }
                                                } catch {
                                                    print("Error parsing JSON: \(error.localizedDescription)")
                                                }
                                            }
                                        }
                                      
                                    
                                        
                                        transition = true
                                    } else if httpResponse.statusCode == 400 {
                                        // The response is 400, do something specific
                                        loginResponse = "Error: Bad Request"
                                        showAlert = true

                                        self.alert(isPresented: .constant(true)) {
                                            Alert(title: Text("Error"), message: Text(loginResponse!))
                                        }
                                    } else {
                                        showAlert = true

                                        // Some other status code was returned, handle it appropriately
                                        loginResponse = "Error: \(httpResponse.statusCode)"
                                        self.alert(isPresented: .constant(true)) {
                                            Alert(title: Text("Error"), message: Text(loginResponse!))
                                        }
                                    }
                                } else {
                                    // Something went wrong, handle the error
                                    loginResponse = "Error: \(error?.localizedDescription ?? "Unknown error")"
                                    self.alert(isPresented: .constant(true)) {
                                        Alert(title: Text("Error"), message: Text(loginResponse!))
                                    }
                                }
                            }.resume()

                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.red]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                    }
                  
                    Button(action: {
                        
                    }) {
                        Text(" Google Sign In")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.gray, Color.black]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                    }
                    
                   
                   
                    .toggleStyle(SwitchToggleStyle())
                    
                    Button(action: {
                        isPresentingSignUp = true
                    }, label: {
                        Text("Don't have an account? Sign up here")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .background(Color.white)
                            .cornerRadius(8)
                    })
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    
                    // Navigation link to sign up view
                    
                    NavigationLink(destination: SignUpView1(), isActive: $isPresentingSignUp) {
                        EmptyView()
                    }
                    .hidden()
//                    NavigationLink(destination:
//                                    POSTSPANEL(), isActive: $transition) {
//                        EmptyView()
//                    }
                    NavigationLink(destination: POSTSPANEL()
                        .navigationBarBackButtonHidden(true), isActive: $transition) {
                            EmptyView()
                    }

                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)
                    .hidden()
                    
                     
                }
                .navigationTitle("RadioFy Login")
                .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text(loginResponse ?? "Unknown error"))
                            }
                .navigationBarTitleDisplayMode(.inline) // set the display mode to inline

                .navigationViewStyle(.stack)
                .onAppear {
                    if let savedEmail = UserDefaults.standard.string(forKey: "emailLogin"),
                       let savedPassword = UserDefaults.standard.string(forKey: "passwordLogin") {
                        email = savedEmail
                        password = savedPassword
                      print(email,password)
                        transition = true
                        
                    }
                }
                NavigationLink(destination: forget()) {
                    Text("Forgot Password")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .cornerRadius(8)
                    
                }
              
            }
        }
        func isValidEmail(_ email: String) -> Bool {
            // validate email
            return email.contains("@") && email.contains(".")
        }
        
        func isValidPassword(_ password: String) -> Bool {
            // validate password
            return password.count >= 8
        }
    }
struct LoginResponse: Decodable {
    let success: Bool
}
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }

