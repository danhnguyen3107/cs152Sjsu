var foldl = function (f, acc, array) {
    for (let i = 0; i < array.length; i++)
        acc = f(array[i], acc);

    return acc;
}

console.log(foldl(function(x,y){return x+y}, 0, [1,2,3]));
console.log(foldl(function(x,acc){return [x].concat(acc)}, [], [1,2,3]));

var foldr = function (f, z, array) {
    for (let i = array.length - 1; i >= 0; i--)

        z = f(array[i], z);

    return z;
}

console.log(foldr(function(x,y){return x/y}, 1, [2,4,8]));
console.log(foldr(function(x,acc){return [x].concat(acc)}, [], [1,2,3]));

var map = function (f, array) {
    var newArray = new Array();

    for (var i = 0; i < array.length; i++)

        newArray[i] = f(array[i]);

    return newArray;
}

console.log(map(function(x){return x+x}, [1,2,3,5,7,9,11,13]));
