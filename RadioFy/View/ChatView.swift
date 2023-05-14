import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @State private var message: String = ""

    init(webSocketManager: WebSocketManager, roomName: String, userName: String) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(webSocketManager: webSocketManager, roomName: roomName, userName: userName))
    }

    var body: some View {
        VStack {
            List(viewModel.messages) { chatMessage in
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

            HStack {
                TextField("Type your message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    viewModel.sendMessage(message)
                    message = ""
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.subscribe()
        }
    }
}
