const express = require('express');
const path = require('path');
require('dotenv').config();

// app de express
const app = express();

// crear el servidor de socket
// node server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);

// llamar al fichero de mensajes de socket
require('./sockets/socket');

// path publico
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

server.listen(process.env.PORT, (err) => {
    if (err) throw new Error(err);

    console.log('Servidor en puerto', process.env.PORT);
});