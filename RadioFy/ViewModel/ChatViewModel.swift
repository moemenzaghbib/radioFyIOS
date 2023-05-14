import Foundation
import Combine

struct ChatMessage: Identifiable {
    let id = UUID()
    let message: String
    let isCurrentUser: Bool
}

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private let webSocketManager: WebSocketManager
    private var roomName: String
    private var userName: String

    init(webSocketManager: WebSocketManager, roomName: String, userName: String) {
        self.webSocketManager = webSocketManager
        self.roomName = roomName
        self.userName = userName
    }

    func subscribe() {
        webSocketManager.subscribe(roomName: roomName, userName: userName)
    }

    func sendMessage(_ message: String) {
        webSocketManager.send(message, roomName: roomName)
        let chatMessage = ChatMessage(message: message, isCurrentUser: true)
        messages.append(chatMessage)
    }
}
