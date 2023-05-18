//import Foundation
//import Combine
//
//struct ChatMessage: Identifiable {
//    let id = UUID()
//       let userName: String
//       let message: String
//       let isCurrentUser: Bool}
//struct UserJoined: Identifiable {
//    var id = UUID()
//    var userName: String
//}
//struct UserLeft: Identifiable {
//    let id = UUID()
//    let userName: String
//}
//
//
//class ChatViewModel: ObservableObject {
//    @Published var userLeft: UserLeft?
//
//    @Published var messages: [ChatMessage] = []
//     let webSocketManager: WebSocketManager
//     var roomName: String
//     var userName: String
//    @Published var userJoined: UserJoined?
//
//    init(webSocketManager: WebSocketManager, roomName: String, userName: String) {
//        self.webSocketManager = webSocketManager
//        self.roomName = roomName
//        self.userName = userName
//        self.webSocketManager.onNewMessageReceived = { [weak self] (userName, message) in
//            let isCurrentUser = userName == self?.userName
//            let chatMessage = ChatMessage(userName: userName, message: message, isCurrentUser: isCurrentUser)
//            DispatchQueue.main.async {
//                self?.messages.append(chatMessage)
//            }
//
//
//            self!.webSocketManager.onUserJoined = { userName in
//                print("\(userName) joined the chat")
//                self!.userJoined = UserJoined(userName: userName)
//            }
//            self!.webSocketManager.onUserLeft = { userName in
//                print("\(userName) left the chat")
//                self!.userLeft = UserLeft(userName: userName)
//            }
//        }
//        func subscribe(roomName: String, userName: String) {
//            webSocketManager.subscribe(roomName: roomName, userName: userName)
//        }
//
//        func sendMessage(_ message: String) {
//            webSocketManager.send(message, roomName: roomName, userName: userName)
//            let chatMessage = ChatMessage(userName: userName, message: message, isCurrentUser: true)
//            messages.append(chatMessage)
//        }
//
//    }
//}



import Foundation
import Combine

struct ChatMessage: Identifiable {
    let id = UUID()
    let userName: String
    let message: String
    let isCurrentUser: Bool
}

struct UserJoined: Identifiable {
    var id = UUID()
    var userName: String
}

struct UserLeft: Identifiable {
    let id = UUID()
    let userName: String
}

class ChatViewModel: ObservableObject {
    @Published var userLeft: UserLeft?
    @Published var messages: [ChatMessage] = []
    let webSocketManager: WebSocketManager
    var roomName: String
    var userName: String
    @Published var userJoined: UserJoined?

    init(webSocketManager: WebSocketManager, roomName: String, userName: String) {
        self.webSocketManager = webSocketManager
        self.roomName = roomName
        self.userName = userName

        self.webSocketManager.onNewMessageReceived = { [weak self] (userName, message) in
            let isCurrentUser = userName == self?.userName
            let chatMessage = ChatMessage(userName: userName, message: message, isCurrentUser: isCurrentUser)
            DispatchQueue.main.async {
                self?.messages.append(chatMessage)
            }
        }

        self.webSocketManager.onUserJoined = { [weak self] userName in
            print("\(userName) joined the chat")
            DispatchQueue.main.async {
                self?.userJoined = UserJoined(userName: userName)
            }
        }

        self.webSocketManager.onUserLeft = { [weak self] userName in
            print("\(userName) left the chat")
            DispatchQueue.main.async {
                self?.userLeft = UserLeft(userName: userName)
            }
        }
    }

    func subscribe(roomName: String, userName: String) {
        webSocketManager.subscribe(roomName: roomName, userName: userName)
    }

    func sendMessage(_ message: String) {
        webSocketManager.send(message, roomName: roomName, userName: userName)
        let chatMessage = ChatMessage(userName: userName, message: message, isCurrentUser: true)
        messages.append(chatMessage)
    }
}
