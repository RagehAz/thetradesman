x => {

let output = {};

const title = document.querySelector("#productTitle")?.innerText;

const price = document.querySelector(".a-offscreen")?.innerText;

const importantInfo = document.querySelector("#important-information > div")?.innerText;

const imageList = Array.from(
  document.querySelectorAll(".imgTagWrapper > img")
).map((img) => img.src);

const brand = document.querySelector("#bylineInfo")?.innerText;

const stars = document.querySelector(".a-icon-alt")?.innerText;

const ratings = document.querySelector("#acrCustomerReviewText")?.innerText;


const about = document.querySelector("#feature-bullets")?.innerText

const questions = [];

const description = document.querySelector("#productDescription")?.innerText;

const reviews = [];

 output = {
    title,
    price,
    importantInfo,
    imageList,
    brand,
    stars,
    ratings,
    about,
    questions,
    description,
    reviews,
}

    return output;
}











