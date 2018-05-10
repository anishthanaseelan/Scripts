"use strict";
var x = function(lvar1){
    var val1 = 1;
    var var2 = 2;
    var lvar = lvar1;
    this.add = function(x,y){
        return (x+y+lvar);
    }
    
}


let x1 = new x(1);
let x2 = new x(2);

x2.constructor.prototype.substract = function(x,y){
        return(x-y);
}


console.log(x1.add(12,12) + x1.substract(14,14));
console.log(x2.constructor.prototype.substract(1,2));