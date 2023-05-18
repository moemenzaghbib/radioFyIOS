import SwiftUI

@main
struct RadioFyApp: App {
    var body: some Scene {
        WindowGroup {
//            let socketURL = URL(string: "http://127.0.0.1:3000")!
//            let webSocketManager = WebSocketManager(socketURL: socketURL)
//            let chatView = ChatView(webSocketManager: webSocketManager, userName: "User1", roomName: "Room1")
//            chatView
            LoginView()
        }
    }
}
