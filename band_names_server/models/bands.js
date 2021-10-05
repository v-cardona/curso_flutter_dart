const Band = require("./band");

class Bands {
    constructor() {
        this.bands = [];
    }

    addBand(band = new Band()) {
        this.bands.push(band);
    }

    getBands() {
        return this.bands;
    }

    deleteBand(id = '') {
        this.bands = this.bands.filter(band => band.id !== id);
        return this.bands;
    }

    voteBand(id = '') {
        // el map devuelve la referencia al elemento
        this.bands = this.bands.map(band => {
            // si es la banda del id, sumarle el voto y devolverla
            if (band.id == id) {
                band.vote++;
                return band;
            } else {
                // eoc, devolver la banda sin modificarla
                return band;
            }
        });
    }
}

module.exports = Bands;