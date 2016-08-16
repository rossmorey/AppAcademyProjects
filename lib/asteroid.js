const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");

function Asteroid (pos, game) {
  const COLOR = "#00ffff";
  const RADIUS = 20;
  let vel = Util.randomVec(10);

  MovingObject.call(this, pos, vel, RADIUS, COLOR, game);
}



Util.inherits(Asteroid, MovingObject);
module.exports = Asteroid;
