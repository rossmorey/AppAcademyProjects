/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const Router = __webpack_require__(1);
	const Inbox = __webpack_require__(2);

	document.addEventListener('DOMContentLoaded', () => {
	  let routes = {
	    inbox: Inbox
	  };

	  let content = document.querySelector('.content');
	  let router = new Router(content, routes);
	  router.start();

	  let lis = document.querySelectorAll('.sidebar-nav li');

	  for (let i = 0; i< lis.length; i++) {
	    let li = lis[i];
	    li.addEventListener('click', (e) => {
	      let ct = e.currentTarget;
	      let newLocation = ct.innerText.toLowerCase();
	      window.location.hash = newLocation;
	    });
	  }



	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	function Router (node, routes) {
	  this.node = node;
	  this.routes = routes;
	}

	Router.prototype.start = function () {
	  window.addEventListener("hashchange", this.render.bind(this));
	};

	Router.prototype.render = function () {
	  this.node.innerHTML = "";
	  let component = this.activeRoute();

	  if (component){
	    let domNode = component.render();
	    this.node.appendChild(domNode);
	  }

	};

	Router.prototype.activeRoute = function () {
	  let activeR =  window.location.hash.slice(1);
	  return this.routes[activeR];
	};

	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports) {

	let Inbox = {};

	Inbox.render = function(){
	  let node = document.createElement('ul');
	  node.className = "messages";
	  node.innerHTML = "An Inbox Message";
	  return node;
	};


	module.exports = Inbox;


/***/ }
/******/ ]);