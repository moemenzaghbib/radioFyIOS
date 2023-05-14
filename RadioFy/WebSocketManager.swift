import Foundation
import SocketIO

class WebSocketManager {
    private let manager: SocketManager
    private let socket: SocketIOClient
    private(set) var connected: Bool = false

    init(socketURL: URL) {
        manager = SocketManager(socketURL: socketURL, config: [.log(false), .compress])
        socket = manager.defaultSocket
        connect()
    }

    func connect() {
        socket.connect()
        configureCallbacks()
        connected = true
    }

    func subscribe(roomName: String, userName: String) {
        guard connected else {
            print("Not connected to the server")
            return
        }
        let roomData: [String: Any] = ["roomName": roomName, "userName": userName]
        socket.emit("subscribe", roomData) {
            print("Subscribed to room: \(roomName)")
        }
    }

    func send(_ message: String, roomName: String) {
        guard connected else {
            print("Not connected to the server")
            return
        }
        let messageData: [String: Any] = ["messageContent": message, "roomName": roomName]
        socket.emit("newMessage", messageData) {
            print("Sent message: \(message)")
        }
    }

    private func configureCallbacks() {
        socket.on(clientEvent: .connect) { data, ack in
            print("Connected to the socket server")
        }

        socket.on(clientEvent: .error) { data, ack in
            if let error = data.first as? String {
                print("Error: \(error)")
            }
        }

        socket.on("newUserToChatRoom") { data, ack in
            if let userName = data[0] as? String {
                print("User \(userName) joined the room")
            }
        }

        socket.on("userLeftChatRoom") { data, ack in
            if let userName = data[0] as? String {
                print("User \(userName) left the room")
            }
        }

        socket.on("updateChat") { data, ack in
            if let chatData = data[0] as? [String: Any],
               let userName = chatData["userName"] as? String,
               let messageContent = chatData["messageContent"] as? String {
                print("[\(userName)] \(messageContent)")
            }
        }
    }
}
