/**
 * @author ZAGHBIB Moemen
 * @email moemen.zaghbib@esprit.tn
 * @create date 2022-11-02 12:22:30
 * @modify date 2023-05-18 20:51:33
 * @desc socket.io server !
 */

const express = require('express');
const bodyParser = require('body-parser');


const socketio = require('socket.io')
var io = require('socket.io')(server);

var app = express();

// parse application/x-www-form-urlencoded
// { extended: true } : support nested object
// Returns middleware that ONLY parses url-encoded bodies and 
// This object will contain key-value pairs, where the value can be a 
// string or array(when extended is false), or any type (when extended is true)
app.use(bodyParser.urlencoded({ extended: true }));

//This return middleware that only parses json and only looks at requests where the Content-type
//header matched the type option. 
//When you use req.body -> this is using body-parser cause it is going to parse 
// the request body to the form we want
app.use(bodyParser.json());

const port = process.env.PORT || 3000;
var server = app.listen(port,()=>{
    console.log('Server is running on port number 3000')
})



//Chat Server

var io = require('socket.io')(server);

io.on('connection',function(socket) {

    //The moment one of your client connected to socket.io server it will obtain socket id
    //Let's print this out.
    console.log(`Connection : SocketId = ${socket.id}`)
    //Since we are going to use userName through whole socket connection, Let's make it global.   
    var userName = '';
    
    socket.on('subscribe', function(data) {
        console.log('subscribe trigged')
        console.log(data);
        const room_data = data
        userName = room_data.userName;
        const roomName = room_data.roomName;
    
        socket.join(`${roomName}`)
        console.log(`Username : ${userName} joined Room Name : ${roomName}`)
        
       
        // Let the other user get notification that user got into the room;
        // It can be use to indicate that person has read the messages. (Like turns "unread" into "read")

        //TODO: need to chose
        //io.to : User who has joined can get a event;
        //socket.broadcast.to : all the users except the user who has joined will get the message
        // socket.broadcast.to(`${roomName}`).emit('newUserToChatRoom',userName);
        io.to(`${roomName}`).emit('newUserToChatRoom',userName);

    })

    socket.on('unsubscribe',function(data) {
        console.log('unsubscribe trigged')
        const room_data = data
        const userName = room_data.userName;
        const roomName = room_data.roomName;
    
        console.log(`Username : ${userName} leaved Room Name : ${roomName}`)
        socket.broadcast.to(`${roomName}`).emit('userLeftChatRoom',userName)
        socket.leave(`${roomName}`)
    })

    socket.on('newMessage',function(data) {
        console.log('newMessage triggered')
            console.log(data)
        const messageData = data
        const messageContent = messageData.messageContent
        const roomName = messageData.roomName
const userName = messageData.userName
        console.log(`[Room Number ${roomName}] ${userName} : ${messageContent}`)
        // Just pass the data that has been passed from the writer socket

        const chatData = {
            userName : userName,
            messageContent : messageContent,
            roomName : roomName
        }
        socket.broadcast.to(`${roomName}`).emit('updateChat',chatData) // Need to be parsed into Kotlin object in Kotlin
    })

    // socket.on('typing',function(roomNumber){ //Only roomNumber is needed here
    //     console.log('typing triggered')
    //     socket.broadcast.to(`${roomNumber}`).emit('typing')
    // })

    // socket.on('stopTyping',function(roomNumber){ //Only roomNumber is needed here
    //     console.log('stopTyping triggered')
    //     socket.broadcast.to(`${roomNumber}`).emit('stopTyping')
    // })

    socket.on('disconnect', function () {
        console.log("One of sockets disconnected from our server.")
    });
})

module.exports = server; //Exporting for test