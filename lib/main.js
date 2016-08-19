const DOMNodeCollection = require('./dom_node_collection.js');

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
