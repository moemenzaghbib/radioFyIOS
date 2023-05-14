//import Foundation
//import Combine
//
//class WebSocketManagerWrapper: ObservableObject {
//     let webSocketManager: WebSocketManager
//
//    init(socketURL: URL, userName: String) {
//        webSocketManager = WebSocketManager(socketURL: socketURL, userName: userName)
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
//    func sendMessage(_ message: String, roomName: String) {
//        webSocketManager.sendMessage(message, roomName: roomName, userName: webSocketManager.userName)
//    }
//}
