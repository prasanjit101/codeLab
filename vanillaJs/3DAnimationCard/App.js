const card = document.querySelector(".card");
const container = document.querySelector(".container");
const image = document.querySelector(".image_class img");
const options = document.querySelector(".options");
const description = document.querySelector(".info h3");
const title = document.querySelector(".title");
const main_button = document.querySelector(".main_button");


container.addEventListener("mousemove", (e) => {
  let xAxis = (window.innerWidth / 2 - e.pageX) / 25;
  let yAxis = (window.innerHeight / 2 - e.pageY) / 25;
  card.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
});
//Animate In
container.addEventListener("mouseenter", (e) => {
  card.style.transition = "none";
  title.style.transform = "translateZ(150px)";
  image.style.transform = "translateZ(200px) rotateZ(-25deg)";
  description.style.transform = "translateZ(125px)";
  options.style.transform = "translateZ(100px)";
  main_button.style.transform = "translateZ(75px)";
});
//Animate Out
container.addEventListener("mouseleave", (e) => {
  card.style.transition = "all 0.5s ease";
  card.style.transform = `rotateY(0deg) rotateX(0deg)`;
  title.style.transform = "translateZ(0px)";
  image.style.transform = "translateZ(0px) rotateZ(0deg)";
  description.style.transform = "translateZ(0px)";
  options.style.transform = "translateZ(0px)";
  main_button.style.transform = "translateZ(0px)";
});
