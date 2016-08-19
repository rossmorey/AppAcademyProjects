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
