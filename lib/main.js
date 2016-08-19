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

window.$l.extend = function(...objs){
  let result = {};
  objs.forEach(obj=>{
    let k = Object.keys(obj);
    k.forEach(key=>{
      result[key] = obj[key];
    });
  });
  return result;
};

window.$l.ajax = function(options){
  let defaults = {
    type: 'GET',
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    context: document.body,
    dataType: 'json',
    headers: {},
    method: 'GET',
    success: function(message){console.log(message);},
    data: "",
    url: window.location.pathname
  };
  if(!options){options = {};}

  options = $l.extend(defaults, options);

  const xhr = new XMLHttpRequest();
  xhr.open(options['method'], options['url']);
  xhr.onload = function(){
    if (xhr.status === 200){
      options['success'](xhr.response);
    }
  };
  xhr.send(options["data"]);
};

// $l.ajax({
//   url:'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
//   success: function(message){ console.log(message);}
// })
