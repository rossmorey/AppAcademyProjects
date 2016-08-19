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

  append(){

  }

}

module.exports = DOMNodeCollection;
