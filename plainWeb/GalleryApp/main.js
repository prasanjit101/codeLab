const image = document.querySelector('.image');
const bar = document.querySelector('.thumb-bar');

let count = 0;

for (var i = 1 ; i < 6 ; i++) {

const newImage = document.createElement('img');
var imgSrc = "images/pic"  + i + ".jpg";
newImage.setAttribute('src', imgSrc.toString());
bar.appendChild(newImage);

 newImage.onclick = function(e) {
    image.src = e.target.src;
  }
}
