const Asteroid = require("./asteroid.js");
const Ship = require("./ship.js");
const DIM_X = 1000;
const DIM_Y = 600;
const NUM_ASTEROIDS = 2;

function Game() {
  this.asteroids = [];
  this.addAsteriods();
  this.ship = new Ship(this);
}
Game.prototype.randomPosition = function () {
  let x = Math.floor(Math.random() * DIM_X);
  let y = Math.floor(Math.random() * DIM_Y);
  return [x, y];
};

Game.prototype.addAsteriods = function() {
  for (let idx = 0; idx < NUM_ASTEROIDS; idx++) {
    let randompos = this.randomPosition();
    let asteroid = new Asteroid(randompos, this);
    this.asteroids.push(asteroid);
  }
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, 1000, 600);
  this.allObjects().forEach(function (el) {
    el.draw(ctx);
  });
};

Game.prototype.moveObjects = function () {
  this.allObjects().forEach(function (el) {
    el.move();
  });
};
Game.prototype.wrap = function (pos) {
  let [x, y] = pos;
  if (y <= 0) {
    return [x, 600];
  } else if (y >= 600) {
    return [x, 0];
  } else if (x <= 0) {
    return [1000, y];
  } else if (x >= 1000) {
    return [0, y];
  } else {
    return [x, y];
  }
};

Game.prototype.checkCollisions = function () {
  this.asteroids.forEach( (a1) => {
    if (a1.isCollidedWith(this.ship)) {
      this.ship.relocate();
    }
  });
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.allObjects = function() {
  return this.asteroids.concat(this.ship);
};

module.exports = Game;

// let g = new Game();
// g.addAsteriods();
