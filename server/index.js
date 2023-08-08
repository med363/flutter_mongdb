// const express = require('express');
// const http = require('http');
// const app = express();
// const Server = http.createServer(app);
// const io = require('socket.io')(Server);
// app.get('/',(req,res)=>{
//     res.json({msg:"API working successfully"})
// })

// //channel
// io.on("connection",(client)=>{
//     console.log("new client connected");
//     client.on('msg',(data)=>{
//         console.log(data);
//         // client.broadcast.emit('res',data)
//         client.to(client.id).emit('res',data)

//     })
// })

//      Server.listen(3000)
const express = require('express');
const {createServer} = require("http");
const { Server } = require("socket.io");

const app = express();
const httpServer = createServer(app)
const io = new Server(httpServer);

app.route("/").get((req,res)=>{
    res.json("Hey there welcome again")})

    io.on("connection", (socket)=>{
        socket.join("anomynous_group")
        console.log("backend connected");
        socket.on("sendMsg",(msg)=>{
            console.log("msg", msg);
            // socket.emit("sendMsgServer",{...msg, type:"otherMsg"})
            // socket.broadcast.emit("sendMsgServer",{...msg, type:"otherMsg"})
            io.to("anomynous_group").emit("sendMsgServer",{...msg,type:"otherMsg"});
        })
        //....
    });

    httpServer.listen(3000)
