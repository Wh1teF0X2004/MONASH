class Parcel {
    constructor(sender, address){
        this.sender = sender;
        this.address = address;
        this.id = Math.round(Math.random()*1000);
    }
}

module.exports = Parcel;