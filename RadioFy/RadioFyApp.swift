import SwiftUI

@main
struct RadioFyApp: App {
    var body: some Scene {
        WindowGroup {
            let socketURL = URL(string: "ws://127.0.0.1:3000")!
            let webSocketManager = WebSocketManager(socketURL: socketURL)
            let chatView = ChatView(webSocketManager: webSocketManager, roomName: "Room1", userName: "User1")
            chatView
        }
    }
}
