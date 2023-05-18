import Foundation
import SocketIO

class WebSocketManager {
    private let manager: SocketManager
    private let socket: SocketIOClient
    private(set) var connected: Bool = false
    var onNewMessageReceived: ((String, String) -> Void)?
    var onUserJoined: ((String) -> Void)?
    var onUserLeft: ((String) -> Void)?
    
    init(socketURL: URL) {
        manager = SocketManager(socketURL: socketURL, config: [.log(false), .compress])
        socket = manager.defaultSocket
        socket.connect()
        configureCallbacks()
       
    }
    
    func connect() {
        if connected {
            print("Already connected to the socket server")
            return
        }
        
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
        connected = false
    }
    
    func subscribe(roomName: String, userName: String) {
        if connected {
            let roomData: [String: Any] = ["roomName": roomName, "userName": userName]
            socket.emit("subscribe", with: [roomData]) {
                print("Subscribed to room: \(roomName)")
            }
        } else {
            socket.once("connect") { [weak self] _, _ in
                let roomData: [String: Any] = ["roomName": roomName, "userName": userName]
                self?.socket.emit("subscribe", with: [roomData]) {
                    print("Subscribed to room: \(roomName)")
                }
            }
        }
    }
    
    func send(_ message: String, roomName: String, userName: String) {
        guard connected else {
            print("Cannot send message. Not connected to the server")
            return
        }
        
        let messageData: [String: Any] = ["messageContent": message, "roomName": roomName, "userName": userName]
        socket.emit("newMessage", with: [messageData]) {
            print("Sent message: \(message)")
        }
    }
    
    private func configureCallbacks() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            print("Connected to the socket server")
            self?.connected = true
        }
        
        socket.on(clientEvent: .disconnect) { [weak self] _, _ in
            print("Disconnected from the socket server")
            self?.connected = false
        }
        
        socket.on(clientEvent: .error) { [weak self] data, _ in
            if let error = data.first as? String {
                print("Socket error: \(error)")
            }
        }
        
        socket.on("newUserToChatRoom") { [weak self] data, _ in
            if let userName = data.first as? String {
                print("User \(userName) joined the room")
                self?.onUserJoined?(userName)
            }
        }
        
        socket.on("userLeftChatRoom") { [weak self] data, _ in
            if let userName = data.first as? String {
                print("User \(userName) left the room")
                self?.onUserLeft?(userName)
            }
        }
        
        socket.on("updateChat") { [weak self] data, _ in
            print("chatData",data)

            if let chatData = data.first as? [String: Any],
               let userName = chatData["userName"] as? String,
               let messageContent = chatData["messageContent"] as? String {
                print("[\(userName)] \(messageContent)")
                self?.onNewMessageReceived?(userName, messageContent)
            }
        }
    }
}
