# Design ideas

I apply the Material design and used some open-source library to complete this application.

Include two pages in total.(Home page and user detail page)

## Customize common title bar

- Use AppBarLayout and Toolbar to implement title bar as a common title bar.

## Home page

- Use CoordinatorLayout as a parent layout.
- Use common title bar as title.
- Use SearchView and menu to implement search function which in the title bar.
- Use RecyclerView to implement user list.
- Use SwipeRefreshLayout to implement pull down to refresh.
- Use RecyclerView.OnScrollListener to implement pull up to load more data.
- Use CardView to implement list element layout.
- Use custom ripple to implement CardView's click effect.
- Use okhttp to implement network GET request.
- Use Glide to load image.
- Use Gson to parse the data.
- Use Enums to distinguish different data status in adapter.
- Use handler to implement communication between threads.

## User detail page

- Use CoordinatorLayout as a parent layout.
- Use common title bar as title and add a back icon to the left of the title.
- Use WebView to load url.
- Use ProgressBar to see the loading progress.

## Others

- Add network permission.
- Create a network util to check network status.
- Use Transition animation.
- Add leakcanary to check Memory leak.


# Wiredcraft Mobile Developer Coding Test

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Requirements

We have multiple tests in this repo. Please read the one you received, and don't confuse with the others.

## What We Care About

Feel free to use any libraries you would use if this were a real production App, but remember we're interested in your code & the way you solve the problem, not how well you can use a particular library.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

Here's what you should aim for:

- Good use of current structure, security & performance best practices.
- Solid testing approach.
- Extensible code.

## Q&A

> Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think you are done. We don't have a deadline for the task.

> What if I have a question?

Create a new issue in the repo and we will get back to you very quickly.
