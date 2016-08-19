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

$l.ajax({
  url:'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
  success: function(message){ console.log(message);}
})
