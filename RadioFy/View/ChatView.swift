import SwiftUI

import SwiftUI
import SwiftUI
import Combine

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @State private var message: String = ""

    init(webSocketManager: WebSocketManager, userName: String, roomName: String) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(webSocketManager: webSocketManager, roomName: roomName, userName: userName))
    }

    var body: some View {
        VStack {
            List(viewModel.messages) { chatMessage in
                VStack(alignment: chatMessage.isCurrentUser ? .trailing : .leading) {
                    Text(chatMessage.userName) // Display the sender's user name
                           .font(.caption)
                           .foregroundColor(.secondary)
                    HStack {
                        if chatMessage.isCurrentUser {
                            Spacer()
                            Text(chatMessage.message)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            Text(chatMessage.message)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type your message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    if !message.isEmpty {
                        viewModel.sendMessage(message)
                        message = ""
                    }
                }

                .onAppear {
                    viewModel.subscribe(roomName: "room1", userName: "userName")
                }

            }
            .padding()
        }
        .onAppear {
            viewModel.subscribe(roomName: "roomName", userName: "userName")
        }
        .alert(item: $viewModel.userJoined) { userJoined in
            Alert(title: Text("User Joined"), message: Text("\(userJoined.userName) has joined the room."), dismissButton: .default(Text("OK")))
        }
    }
}
