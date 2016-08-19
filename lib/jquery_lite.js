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

	const DOMNodeCollection = __webpack_require__(2);

	window.$l = function (selector){
	  let queue = [];
	  if (typeof selector === 'function'){
	    queue.push(selector);
	  } else if(selector instanceof HTMLElement){
	    return new DOMNodeCollection([selector]);
	  } else {
	    const nodeList = document.querySelectorAll(selector);
	    const arrayNodeList = Array.prototype.slice.call(nodeList);
	    return new DOMNodeCollection(arrayNodeList);
	  }


	  document.addEventListener('DOMContentLoaded', function(){
	    queue.forEach(fn =>{
	      fn.call();
	    });
	  });
	};


/***/ },
/* 1 */,
/* 2 */
/***/ function(module, exports) {

	class DOMNodeCollection{
	  constructor(arrHTMLElements){
	    this.HTMLElements = arrHTMLElements;
	  }

	  html(str){
	    if(str){
	      this.HTMLElements.forEach(node=>{
	        node.innerHTML = str;
	      });
	    } else {
	      return this.HTMLElements[0].innerHTML;
	    }
	  }

	  empty(){
	    this.HTMLElements.forEach(node=>{
	      node.innerHTML = "";
	    });
	  }

	  // $('div').append('<li>Hello</li>')
	  append(arg){
	    if (typeof arg === "string") {
	      this.HTMLElements.forEach((node) =>{
	        node.innerHTML += arg;
	      });
	    } else if (arg instanceof HTMLElement) {
	      this.HTMLElements.forEach(node => {
	        node.innerHTML += arg.outerHTML;
	      });
	    } else {
	      this.HTMLElements.forEach(node=>{
	        arg.HTMLElements.forEach(child=>{
	          node.innerHTML += child.outerHTML;
	        });
	      });
	    }
	  }

	  attr(name, value){
	    this.HTMLElements.forEach(node=>{
	      node.setAttribute(name, value);
	    });
	  }

	  addClass(classVal){
	    this.HTMLElements.forEach(node=>{
	      node.className = node.className +" "+classVal;
	    });
	  }
	  removeClass(classVal){
	    this.HTMLElements.forEach(node=>{
	      let temp = node.className.split(" ");
	      let idx = temp.indexOf(classVal);
	      temp[idx] = "";
	      node.className = temp.join(" ");
	    });
	  }

	  children () {
	    let children = [];
	    this.HTMLElements.forEach(node=>{
	      children = children.concat(node.children);
	    });
	    return new DOMNodeCollection(children);
	  }

	  parent () {
	    let parent = [];
	    this.HTMLElements.forEach(node=>{
	      parent = parent.concat(node.parentElement);
	    });
	    return new DOMNodeCollection(parent);
	  }

	  find (selector) {
	    let result = [];
	    this.HTMLElements.forEach((node) => {
	      result = result.concat(node.querySelectorAll(selector));
	    });
	    return new DOMNodeCollection(result);
	  }

	  remove () {
	    this.HTMLElements.forEach((node) => {
	      node.remove();
	    });
	  }

	  on (type, callback) {
	    this.HTMLElements.forEach((node) => {
	      node.addEventListener(type, callback);
	    });
	  }

	  off (type, callback) {

	    this.HTMLElements.forEach((node) => {
	      node.removeEventListener(type, callback);
	    });
	  }
	}

	module.exports = DOMNodeCollection;


/***/ }
/******/ ]);