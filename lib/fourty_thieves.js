
x => {

let output = {};

const title = document.querySelector("#productTitle").innerText;

const price = document.querySelector(".a-offscreen").innerText;

const importantInfo = document.querySelector("#important-information > div").innerText;

const imageList = Array.from(
  document.querySelectorAll(".imgTagWrapper > img")
).map((img) => img.src);

const brand = document.querySelector("#bylineInfo").innerText;

const stars = document.querySelector(".a-icon-alt").innerText;

const ratings = document.querySelector("#acrCustomerReviewText").innerText;

const specfications = {};
const tbody = document.querySelector(
  "#poExpander > div.a-expander-content.a-expander-partial-collapse-content > div > table > tbody"
).children;
for (let i = 0; i < tbody.length; i++) {
  const tr = tbody[i];
  const key = tr.children[0].innerText;
  const value = tr.children[1].innerText;
  specfications[key] = value;
}


const about = Array.from(document.querySelector("#feature-bullets").children).pop().innerText

const details = {};
const detailBullets = document.querySelectorAll("#detailBullets_feature_div")[1].children[0].children
for (let i = 0; i < detailBullets.length; i++) {
    const li = detailBullets[i].children[0];
    let key = li.children[0].innerText;
    key = key.replace(":", "");
    key = key.replace(" ", "");
    key = key.trim()
    const value = li.children[1].innerText;
    details[key] = value;
    }

const questions = [];
const askTeaserQuestions = Array.from(document.querySelector(".askTeaserQuestions").children);
askTeaserQuestions.forEach((askTeaserQuestion) => {
    const tmp = askTeaserQuestion.children[0].children[1];
    const question = tmp.children[0].children[0].children[1].innerText;
    let answer = tmp.children[1].children[0].children[1].innerText.split('\n');
    if (answer.length == 4){
        answer.pop();
    }
 answer =   answer.join('\n')
    questions.push({question,  answer});

    });

const description = document.querySelector("#productDescription").innerText;

const reviews = [];

const reviewList = Array.from(document.querySelector("#cm-cr-dp-review-list").children);

reviewList.forEach((review) => {
    const tmp = review.children[1].id
    const image = document.querySelector(`#${tmp} > div > div > a > div > div > img`).src;
    const title = document.querySelector(`#${tmp} > div > div`).innerText.trim();
    const stars = document.querySelector(`#${tmp} > div > div:nth-child(2)  > a:nth-child(1)`).title
    const ratingTitle = document.querySelector(`#${tmp} > div > div:nth-child(2)  > a:nth-child(3)`).innerText
    const ratingBody = document.querySelector(`#${tmp} > div > div:nth-child(5)`).innerText
    reviews.push({image, title, stars, ratingTitle, ratingBody});
});

const badges = document.querySelector("#icon-farm-container > div").children;

const badgesList = [];

for (let i = 0; i < badges.length; i++) {
    const badge = badges[i].children;
    if (badge.length == 1) {
        let image = badge[0].firstElementChild.firstElementChild.src

        let title = badge[0].lastElementChild.innerText
        badgesList.push({title,image});
        continue;
    }
let image = badge[0].firstElementChild.src
let title = badge[1].innerText
    badgesList.push({title, image});
}

 output = {
    title,
    price,
    imageList,
    brand,
    stars,
    ratings,
    specfications,
    about,
    details,
    questions,
    description,
    reviews,
    importantInfo,
    badgesList
}

    return {
        title,
        price,
        imageList,
        brand,
        stars,
        ratings,
        specfications,
        about,
        details,
        questions,
        description,
        reviews,
        importantInfo,
        badgesList
    };
}
