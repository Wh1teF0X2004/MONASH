/**
 * @author Euan Lim 33045984 <elim0062@student.monash.edu> 
 * @author Foo Kai Yan 33085625 <kfoo0012@student.monash.edu>
 * Represents the mongo schema for 
 */

const mongoose = require("mongoose");

// Schema for operation counters
const operationSchema = new mongoose.Schema({
    addCount: { type: Number, default: 0 },
    updateCount: { type: Number, default: 0 },
    deleteCount: { type: Number, default: 0 }
    // categoryCount: { type: Number, default: 0 },
    // eventCount: { type: Number, default: 0 }
});
  
module.exports = mongoose.model("Operation", operationSchema);