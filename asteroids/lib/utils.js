const Util = {
  inherits (childClass, parentClass) {
    function Surrogate () {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate;
    childClass.prototype.constructor = childClass;
  },

  randomVec (length) {
    let x = Math.random() * (2 * length) - length;
    let pom = Math.floor(Math.random() * 2);
    let y = Math.sqrt(Math.pow(length, 2) - Math.pow(x, 2));
    if (pom === 1) {
      y = -y;
    }
    return [x, y];
  }
};

module.exports = Util;
// console.log(Util.randomVec(10));
