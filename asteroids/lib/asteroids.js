const GameView = require("./game_view.js");

document.addEventListener("DOMContentLoaded", function() {
  // debugger
  let canvas = document.getElementById("game-canvas");
  let ctx = canvas.getContext("2d");
  let gameview = new GameView(ctx);
  gameview.start();
});
