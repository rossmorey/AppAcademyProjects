const Game = require("./game.js");
function GameView (ctx) {
  this.ctx = ctx;
  this.game = new Game();
}

GameView.prototype.start = function () {
  this.bindKeyHandlers();
  setInterval(() => {
    this.game.draw(this.ctx);
    this.game.step();
  }, 20);

};

GameView.prototype.bindKeyHandlers = function() {
  window.key("w", () => {
    this.game.ship.power([0, -1]);
  });
  window.key("a", () => this.game.ship.power([-1, 0]));
  window.key("s", () => this.game.ship.power([0, 1]));
  window.key("d", () => this.game.ship.power([1, 0]));
};

module.exports = GameView;
