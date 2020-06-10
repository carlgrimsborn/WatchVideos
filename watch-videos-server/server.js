var express = require("express");
var bodyParser = require("body-parser");

var app = express();
// intercept all requests
app.all("/*", function (req, res, next) {
  //security
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "X-Requested-With",
    "Content-Type",
    "Accept"
  );
  res.header("Access-Control-Allow-Methods", "POST", "GET");
  //go to next function
  next();
});

// use middleware. all the request that come in we convert to JSON so we can use it
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

var tutorials = [
  {
    id: 1,
    title: "Android Studio Tutorial For Beginners",
    description:
      "This Android Studio tutorial video will help you learn the basics of Android App development. It is ideal for both beginners and professionals who wants to learn or brush up the basics of Android.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/ZLNO2c7nqjw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/ZLNO2c7nqjw/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 2,
    title: "iOS 13 Swift Tutorial: Awesome new Xcode 11 Features",
    description:
      "A brief overview about some cool new Xcode features like first class Swift Package integration, SwiftUI and SF Symbols.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/vC2BRWrCUlI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/vC2BRWrCUlI/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 3,
    title:
      "What's New in Angular 4 | Angular 4 Features | Angular 4 Changes | Angular 4 Tutorial | Edureka",
    description:
      "This video will help you to understand the changes that have been incorporated in Angular 4. You will learn how to migrate an Angular 2 application to Angular 4.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/zc5oRbP6t2E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail:
      "https://www.edureka.co/blog/wp-content/uploads/2017/07/Whats-New-in-Angular-4-Angular-4-Features-Angular-4-Changes-Angular-Tutorial-Edureka.jpeg",
    comments: [],
  },
  {
    id: 4,
    title: "iOS Swift Tutorial: Create a Circular Transition Animation",
    description:
      "In this tutorial you are going to create a cool circular transition between two ViewControllers that could be used as a menu or to highlight another feature of your Apps.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/B9sH_VxPPo4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/B9sH_VxPPo4/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 5,
    title: "Build a Simple 3D Game: Unity 3D Physics Beginner's Tutorial",
    description:
      "Build a very simple game that shows you the basics of working with Physics in Unity 3D. No prior knowledge is needed to get started.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/u3BnN2oioLA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/u3BnN2oioLA/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 6,
    title: "React Native vs Flutter - Which to Learn?",
    description:
      "In this video you will understand the pros and cons of these frameworks",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/tSyXb0sHBoE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/tSyXb0sHBoE/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 7,
    title: "SwiftUI Basics for Beginners (2020)",
    description:
      "In this SwiftUI tutorial, I’ll demonstrate the basics of this new UI Framework! You're going to get a sneak preview of exactly how Swift UI works as we build a demo project step by step.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/IIDiqgdn2yo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/IIDiqgdn2yo/maxresdefault.jpg",
    comments: [],
  },
  {
    id: 8,
    title: "Kotlin Course - Tutorial for Beginners",
    description:
      "Learn the Kotlin programming language in this introduction to Kotlin. Kotlin is a general purpose, open source, statically typed “pragmatic” programming language. It is used for many things, including Android development.",
    iframe:
      '<div class="container"><iframe class="video" src="https://www.youtube.com/embed/F9UC9DY-vIU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
    thumbnail: "https://i.ytimg.com/vi/F9UC9DY-vIU/maxresdefault.jpg",
    comments: [],
  },
];

var comments = [
  {
    videoId: 1,
    username: "434",
    comment: "This video was really cool",
  },
];

app.post("/comments", (req, res) => {
  var comment = req.body;
  if (comment) {
    if (comment.username && comment.comment && comment.videoId) {
      // comments.push(comment);
      tutorials[comment.videoId].comments.push(comment);
    } else {
      res.send("You posted invalid data");
    }
  } else {
    res.send("Your post has no body");
  }

  console.log(tutorials[comment.videoId].comments);
  res.send("You successfully posted a comment");
});

app.get("/tutorials", (req, res) => {
  console.log("GET from server");
  res.send(tutorials);
});

app.get(`/tutorials/comments/:videoId`, (req, res) => {
  const id = Number(req.params.videoId);
  console.log("GET SPECIFIC", typeof id);
  console.log("GET SPECIFIC", tutorials[id].comments);
  if (tutorials[id].id) {
    if (tutorials[id].comments.length > 0) {
      res.send(tutorials[id].comments);
    } else res.send([]);
  } else res.status(404).send("video with that id not found");
});

app.listen(3000);
