const {io} = require('../index');
const Bands = require('../models/bands');
const Band = require('../models/band');

const bands = new Bands();

bands.addBand(new Band('Metallica'));
bands.addBand(new Band('Queen'));
bands.addBand(new Band('Heroes del silencio'));
bands.addBand(new Band('La fuga'));

// mensajes de sockets
io.on('connection', client => {
    console.log('cliente conectado')

    // al conectarse el cliente, emitirle solo a el el listado de bandas
    client.emit('active-bands', bands.getBands());

    client.on('disconnect', () => { 
        console.log('cliente desconectado')
    });

    // escuchar el evento mensaje
    client.on('mensaje', (payload) => {
        console.log('mensaje', payload);
        // enviar a todos los clientes conectados
        io.emit('mensaje', {admin: 'nuevo mensaje'});
    });

    client.on('vote-band', (payload) => {
        bands.voteBand(payload.id);
        io.emit('active-bands', bands.getBands());
    });
    
    client.on('add-band', (payload) => {
        const newBand = new Band(payload.name);
        bands.addBand(newBand);
        io.emit('active-bands', bands.getBands());
    });

    client.on('delete-band', (payload) => {
        bands.deleteBand(payload.id);
        io.emit('active-bands', bands.getBands());
    });




    
    // escuchar el evento nuevo-mensaje
    client.on('emitir-mensaje', (payload) => {
        // enviar a todos los clientes conectados
        io.emit('nuevo-mensaje', payload);
        // emitir a todos menos el que lo emitió
        client.broadcast.emit('nuevo-mensaje', payload);
    });
});