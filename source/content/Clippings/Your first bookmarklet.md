---
title: "Your first bookmarklet"
source: "https://dev.to/defenderofbasic/your-first-bookmarklet-3213"
author:
  - "[[Defender]]"
published: 2024-05-24
created: 2025-10-30
description: "Bookmarklets are a great way to automate or tweak things across your web experience. I made one... Tagged with javascript, bookmarklet, beginners."
tags:
  - "clippings"
---
Bookmarklets are a great way to automate or tweak things across your web experience. [I made one recently](https://x.com/DefenderOfBasic/status/1788143504671088825) that allows me to click a button to show all my interactions with any given twitter user.

This tutorial will walk you through creating your first bookmarklet to edit a value inside a specific element on the page. It will insert a search term into the HackerNews search element.

![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fjk15xnwuybuiavif89rw.gif)

We're going to:

1. Open the browser devtools to find the HTML element we want
2. Write some JavaScript code in the console to manipulate this element
3. Wrap this code into a bookmark so that when you click it, it runs the code, thus making a "bookmarklet" (a bookmark that runs your code snippet)

## Step 1 - get the element with devtools

I'm going to use this page as an example: [https://news.ycombinator.com/news](https://news.ycombinator.com/news)

In Chrome, right click on the page and click "inspect" to open devtools

[![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fpr8by8cwxtkn4zeddb7g.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fpr8by8cwxtkn4zeddb7g.png)

There's a lot of tools here. The important ones to notice are: (1) you can see the HTML, you can click on parts of the HTML to highlight the element on the page (2) you can use this little picker in the top left to click on any element visually, and it will show you where it is in the HTML.

**Select the picker and then click on the search box** as shown below.

![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fehl3z1nv1nsmf77ikase.gif)

Ok, now we have the HTML element. We need to get its "address" (or CSS selector) so we can get it with JavaScript and control it/do stuff with it.

**Right click on the element** and select "copy" > "copy selector"

[![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F7eai5auru607lcvo86ll.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F7eai5auru607lcvo86ll.png)

It'll be something like this:  

```
#hnmain > tbody > tr:nth-child(4) > td > center > form > input[type=text]
```

## Step 2 - write JavaScript to control the element

Switch to the "console" tab. And paste in the following code and hit enter.  

```
var selector = \`#hnmain > tbody > tr:nth-child(4) > td > center > form > input[type=text]\`
console.log("My element:", document.querySelector(selector))
```

[![Image description](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F2byeo48n7sz9oo6h6zei.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F2byeo48n7sz9oo6h6zei.png)

The first line puts the selector into a variable. This snippet says "get the element, using this selector":  

```
document.querySelector(selector)
```

Finally, `console.log()` prints whatever we put in.

Let's put the element into a variable instead of just printing it:  

```
var element = document.querySelector(selector)
console.log(element)
```

At this point, you can ask ChatGPT what to do/google it. You have an HTML element, in javascript, and we want to do something with it.

In this case, I want to set a search string. To do that, google/chatgpt will tell you:  

```
element.value = "your input here"
```

![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fdx5q1p0we6yr66vfvnhs.gif)

You now have a piece of code that does something! You can continue to tweak this as needed and interactively see if it works, line by line.

My personal process is usually to have a file to save all the "correct code so far" and in the console I'm just writing things line by line to test them. You can refresh to reset the state.

If you wanted another piece of code to submit the "search" so it goes to the search results page, you would get the HTML element of the form that this search bar lives inside, and then google "given an HTML form element, how to submit it with javascript", get the code for that, and test it.

## Step 3 - wrap it into a bookmarklet

Now you have your code that does something. We're going to make it into a bookmark so you can run it on the page with a single button click.

1. Create a bookmark, like you normally would
2. Edit it, and instead of a URL, paste in your code, wrapped in:
```
javascript:(function() { 
// your code here
})();
```

(the only annoying thing right now is you need to add a semicolon at the end of each line for it to work. I might make a tool in the future to automate this part)

So my full code looks like this that I paste into my bookmark:  

```
javascript:(function() { 

var selector = \`#hnmain > tbody > tr:nth-child(4) > td > center > form > input[type=text]\`;
var element = document.querySelector(selector);
element.value = "my search term";

})();
```

That's it!

![](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fjk15xnwuybuiavif89rw.gif)

Discover fresh viewpoints in this insightful post, supported by our vibrant DEV Community. **Every developer’s experience matters** —add your thoughts and help us grow together.

A simple “thank you” can uplift the author and spark new discussions—leave yours below!

On DEV, **knowledge-sharing connects us and drives innovation**. Found this useful? A quick note of appreciation makes a real impact.