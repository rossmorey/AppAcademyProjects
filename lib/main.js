const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function (selector){
  if(selector instanceof HTMLElement){
    return new DOMNodeCollection([selector]);

  } else {
    const nodeList = document.querySelectorAll(selector);
    const arrayNodeList = Array.prototype.slice.call(nodeList);
    return new DOMNodeCollection(arrayNodeList);
  }
};
