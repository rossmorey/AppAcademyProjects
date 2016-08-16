/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(1);
	
	document.addEventListener("DOMContentLoaded", function() {
	  // debugger
	  let canvas = document.getElementById("game-canvas");
	  let ctx = canvas.getContext("2d");
	  let gameview = new GameView(ctx);
	  gameview.start();
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(2);
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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(3);
	const Ship = __webpack_require__(6);
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


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(4);
	const MovingObject = __webpack_require__(5);
	
	function Asteroid (pos, game) {
	  const COLOR = "#00ffff";
	  const RADIUS = 20;
	  let vel = Util.randomVec(10);
	
	  MovingObject.call(this, pos, vel, RADIUS, COLOR, game);
	}
	
	
	
	Util.inherits(Asteroid, MovingObject);
	module.exports = Asteroid;


/***/ },
/* 4 */
/***/ function(module, exports) {

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


/***/ },
/* 5 */
/***/ function(module, exports) {

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


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(5);
	const Utils = __webpack_require__(4);
	
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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map