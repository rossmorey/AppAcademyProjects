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
}

module.exports = DOMNodeCollection;
