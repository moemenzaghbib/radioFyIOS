//
//  singupPanel.swift
//  RadioFy
//
//  Created by imen ben fredj on 14/3/2023.
//

import Foundation
import SwiftUI

struct SignUpView1: View {
    @State private var isPresentingSignIN = false
    @State private var isPresentingSignUp1 = false

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
//user default or key chain for local data storage
    var body: some View {
        
        
        VStack {
            VStack {
                Image("userIcone") // Replace "myLogo" with the name of your
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(10)
                
                HStack {
                    
                    Image(systemName: "person")
                        .foregroundColor(.gray) // Set the color of the image to gray
                        .padding(.leading, 8)
                    TextField("First name", text: $firstName)
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
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray) // Set the color of the image to gray
                        .padding(.leading, 8)
                    TextField("Last name", text: $lastName)
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
                HStack {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.gray) // Set the color of the image to gray
                        .padding(.leading, 8)
                    TextField("Age", text: $age)
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
                
                
                Button(action: {

                    isPresentingSignUp1 = true
                }) {
                    Text("Next")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 330 )
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                NavigationLink(destination: SignUpView2(firstName: firstName, lastName: lastName, age: age), isActive: $isPresentingSignUp1) {
//                        EmptyView()
                }
                .hidden()
                
                Button(action: {
                                    isPresentingSignIN = true
                                }, label: {
                                    Text("Back")
                                        .fontWeight(.bold)
                                        .padding()
                                        .frame(width: 330 )
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .cornerRadius(8)
                                })
                                .fullScreenCover(isPresented: $isPresentingSignIN) {
                                    LoginView()
                                }
                               
                                .padding(.bottom, 20)
                     
                .padding(10)
               
            }
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .shadow(radius: 4)
            .offset(y: 160)
            
            Spacer()
            
        }
        
        .background( LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    struct SignupPanel1_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView1().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
