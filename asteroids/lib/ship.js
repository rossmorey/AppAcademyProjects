const MovingObject = require("./moving_object.js");
const Utils = require("./utils.js");

function Ship (game) {
  const RADIUS = 10;
  const COLOR = "#aa0000";
  this.game = game;
  this.pos = game.randomPosition();
  MovingObject.call(this, this.pos, [0,0], RADIUS, COLOR, game);
}
Utils.inherits(Ship, MovingObject);

Ship.prototype.relocate = function() {
  this.pos = this.game.randomPosition();
  this.vel = [0, 0];
};
Ship.prototype.power = function(impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];

  console.log(this.vel);
};
module.exports = Ship;
