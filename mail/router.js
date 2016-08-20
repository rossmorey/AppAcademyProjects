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
