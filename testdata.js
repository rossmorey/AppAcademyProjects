let ul = $l('.list')

const cb = () => {
  console.log("here");
}
ul.on('click', cb);
// ul.on('click', function () {
//   console.log('clicked');
//   ul.off('click', function(){console.log('turned off');})
// });





let li = $l('.element')
ul.append("<li>Hello World</li>")

let otherUL= $l('.test')
