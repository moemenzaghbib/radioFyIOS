//import Foundation
//
//class WebSocketManagerWrapper: ObservableObject {
//    let webSocketManager: WebSocketManager
//
//    init(socketURL: URL, userName: String) {
//        webSocketManager = WebSocketManager(socketURL: socketURL)
//        webSocketManager.userName = userName
//    }
//
//    func connect() {
//        webSocketManager.connect()
//    }
//
//    func disconnect() {
//        webSocketManager.disconnect()
//    }
//
//    func subscribe(roomName: String, userName: String) {
//        webSocketManager.subscribe(roomName: roomName, userName: userName)
//    }
//
//    func sendMessage(_ message: String, roomName: String, userName: String) {
//        webSocketManager.send(message, roomName: roomName, userName: userName)
//    }
//}
