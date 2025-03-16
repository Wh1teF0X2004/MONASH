console.log('FIT2095');
console.log('Student Name');


var today = new Date();
var dd = today.getDate();

var mm = today.getMonth()+1; 
var yyyy = today.getFullYear();
console.log('the date is:'+dd+'/'+mm+'/'+yyyy);

console.log(today.toLocaleString());


function count(ar, elem){
    let counter=0;
    for(let i=0;i<ar.length;i++){
        if(ar[i]===elem)
            counter++;
    }
    return counter;
}
var array=[1,6,3,8,9,2,1,6,1];
console.log(count(array,1));   


function count(arr){
  const counts = {};

  for (const num of arr) {
    counts[num] = counts[num] ? counts[num] + 1 : 1;
  }
  Object.keys(counts).forEach(key => console.log(key+"-->"+counts[key]))
}
const arr = [5, 5, 5, 2, 2, 2, 2, 2, 9, 4];
count(arr);



class Queue {
    constructor() {
        this.q = [];
    }
// get the current number of elements in the queue
//Getter function
    get length() {
        return this.q.length
    };
//Get all the elements 
    get queue() {
        return this.q;
    }
// Boolean function: returns true if the queue is empty, false otherwise 
    isEmpty() {
        return 0 == this.q.length;
    };
//adds new element to the end of the quue
    enqueue(newItem) {
        this.q.push(newItem)
    };
//Boolean function: returns true if an item is found (first occurnace); false otherwise
    inQueue(item) {
        let i = 0;
        let isFound = false;
        while (i < this.q.length && !isFound) {
            if (this.q[i] === item) {
                isFound = true;
            } else
                i++;
        }
        return (isFound);
    }
// pop an item from the queue
    dequeue() {
        if (0 != this.q.length) {
            let c = this.q[0];
            this.q.splice(0, 1);
            return c
        }
    };

// Function to remove all elements in the queue
    clear() {
        this.q = [];
    }

// Function to add a set of items to the queue
    addAll(items) {
        this.q.push(...items);
    }

    addSetItem(items){
        for (let i=0; i<items.length; i++){
            let item = items[i]
            this.enqueue(item)
        }
    }

// Function to dequeue N elements from the queue
// Rejects the input if there are not enough elements to remove
    dequeueN(count) {
        if (count <= this.q.length) {
            const removedItems = this.q.splice(0, count);
            return removedItems;
        } else {
            throw new Error('Not enough elements in the queue to dequeue.');
        }
    }

    removeN(n){
        for(let i=0; i<n; i++){
            this.dequeue();
        }
    }

// Function to print the content of the queue with their indexes
    printQueue() {
        for (let i = 0; i < this.q.length; i++) {
            console.log(`${i + 1}-->${this.q[i]}`);
        }
    }

};

let queue = new Queue();
queue.enqueue(10);
queue.enqueue(20);
console.log(queue.length);
console.log(queue.q);
queue.dequeue();
queue.enqueue(33);
console.log(queue.q);
console.log(queue.inQueue(33));
console.log(queue.inQueue(88));