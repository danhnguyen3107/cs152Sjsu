"use strict";

// Matches paterns like '3-10'
const RANGE_PAT = /^(\d+)-(\d+)$/;

// Matches negative index values
const FROM_END_PAT = /^-(\d+)$/;

const NUM_PAT = /^-?\d+$/;

function SmartArray(...args) {
  return new Proxy(args, {
    get: function(target, prop) {
      if (prop.match(RANGE_PAT)) {
        // Return a subarray of the elements in the specified range,
        // INCLUDING the specified end index.
        let start = parseInt(prop.replace(RANGE_PAT, "$1"));
        let end = parseInt(prop.replace(RANGE_PAT, "$2")) + 1;
        return target.slice(start, end);
      } else if (prop.match(FROM_END_PAT)) {
        //
        // ***YOUR CODE HERE***
        //
        let index = target.length + Number(prop)
        if (index < 0) throw new Error("Error");
        
        return target[index];
      } else {
        // Do the usual array thing -- get the value at the specified index.
        return Reflect.get(...arguments);
      }
    },
    set: function(target, prop, newVal) {
      //
      // ***YOUR CODE HERE***
      //

        if (prop.match(/^\d+$/)) Reflect.set(...arguments);
        else if(prop.match(FROM_END_PAT)){
            let index = target.length + Number(prop)
            if (index < 0) throw new Error("Error");
            target[index] = newVal
        }else throw new Error("Error");

       return true;

    },
  });
}

let arr = SmartArray('a', 'b', 'c', 'd', 'e', 'f');

console.log(arr[0]); // a
console.log(arr[4]); // e
console.log(arr['hello']); // undefined

console.log(arr['2-4']); // [c,d,E]
console.log(arr['3-5']); // [d,E,f]

console.log(arr[-1]); // f
console.log(arr[-3]); // d

try {
  console.log(arr[-99]);
} catch (e) {
  console.log("Exception correctly thrown.");
}

arr[1] = 'B';
console.log(arr[1]); // B

arr[-2] = 'E';
console.log(arr[4]); // E

try {
  arr['2-4'] = 'hello';
} catch (e) {
  console.log("Exception correctly thrown.");
}

try {
  arr[3*"hello"] = 'hello';
} catch (e) {
  console.log("Exception correctly thrown.");
}

console.log(arr);