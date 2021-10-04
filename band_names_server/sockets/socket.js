const {io} = require('../index');

// mensajes de sockets
io.on('connection', client => {
    console.log('cliente conectado')
    client.on('disconnect', () => { 
        console.log('cliente desconectado')
    });

    // escuchar el evento mensaje
    client.on('mensaje', (payload) => {
        console.log('mensaje', payload);
        // enviar a todos los clientes conectados
        io.emit('mensaje', {admin: 'nuevo mensaje'});
    });
});