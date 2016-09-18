function MovingObject(pos, vel, radius, color, game) {
  this.pos = pos;
  this.vel = vel;
  this.radius = radius;
  this.color = color;
  this.game = game;
}
MovingObject.prototype.draw = function(ctx) {
  ctx.beginPath();
  ctx.fillStyle = this.color;
  let x = this.pos[0];
  let y = this.pos[1];
  ctx.arc(x, y, this.radius, 0, 2 * Math.PI, false);
  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.pos = this.game.wrap(this.pos);
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  let dx = this.pos[0] - otherObject.pos[0];
  let dy = this.pos[1] - otherObject.pos[1];

  let distance = Math.sqrt((Math.pow(dx, 2) + Math.pow(dy, 2)));

  // debugger
  if ((this.radius + otherObject.radius) > distance) {
    return true;
  } else {
    return false;
  }
};

module.exports = MovingObject;
// 
// let a1 = new MovingObject([10,10], [0,0], 10);
// let a2 = new MovingObject([19, 25], [0,0], 10);
// console.log(a1.isCollidedWith(a2));
