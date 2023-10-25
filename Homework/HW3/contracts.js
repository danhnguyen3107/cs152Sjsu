// NOTE: This library uses non-standard JS features (although widely supported).
// Specifically, it uses Function.name.

function any(v) {
    return true;
  }
  
  function isNumber(v) {
    return !Number.isNaN(v) && typeof v === 'number';
  }
  
  function isBoolean(v){
    return !Number.isNaN(v) && typeof v === 'boolean';
  }
  function isDefined(v){
    return !(v === null || v ===undefined)
  }
  function isString(v){
    return !Number.isNaN(v) && (typeof v === 'string' ||  v instanceof String); 
  }
  function isNegative(v){
    return isNumber(v) && v < 0;
  }
  function isPositive(v){
    return isNumber(v) && v > 0;
  }

    isNumber.expected = "number";
    isBoolean.expected = "boolean";
    isString.expected = "string";
    isNegative.expected = "negative number";
    isPositive.expected = "positive number";
    isDefined.expected = "defined";
    

  // Combinators:
  
  function and() {
    let args = Array.prototype.slice.call(arguments);
    let cont = function(v) {
      for (let i in args) {
        if (!args[i].call(this, v)) {
          return false;
        }
      }
      return true;
    }
    cont.expected = expect(args[0]);
    for (let i=1; i<args.length; i++) {
      cont.expected += " and " + expect(args[i]);
    }
    return cont;
  }
  
  //
  // ***YOUR CODE HERE***
  // IMPLEMENT THESE CONTRACT COMBINATORS
  //
  function or(){
    let args = Array.prototype.slice.call(arguments);
    let cont = function(v) {
      for (let i in args) {
        if (args[i].call(this, v)) {
          return true;
        }
      }
      return false;
    }
    cont.expected = expect(args[0]);
    for (let i=1; i<args.length; i++) {
      cont.expected += " and " + expect(args[i]);
    }
    return cont;
  };

  function not(){
    let arg = arguments[0]
    let notf = function(v) {
        return !arg.call(this, v);
    }
    notf.expected = "not " + arg.expected;
    return notf;
  };
  
  
  
  // Utility function that returns what a given contract expects.
  function expect(f) {
    // For any contract function f, return the "expected" property
    // if it is specified.  (This allows developers to specify what
    // the expected property should be in a more readable form.)
    if (f.expected) {
      return f.expected;
    }
    // If the function name is available, use that.
    if (f.name) {
      return f.name;
    }
    // In case an anonymous contract is specified.
    return "ANONYMOUS CONTRACT";
  }
  
  
  function contract (preList, post, f) {
    // ***YOUR CODE HERE***
  }
  
  
  module.exports = {
    contract: contract,
    any: any,
    isBoolean: isBoolean,
    isDefined: isDefined,
    isNumber: isNumber,
    isPositive: isPositive,
    isNegative: isNegative,
    isInteger: Number.isInteger,
    isString: isString,
    and: and,
    or: or,
    not: not,
  };
  