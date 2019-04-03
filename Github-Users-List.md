# Mobile Test - GitHub Users List App

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Context

We are building an App, which is used to list Github user profiles.

## Requirements

### User Stories

1. As a user on app first launch,
    - When I reach the home page
    - Then I should see a list of GitHub users. Each user item on this page should show: name, avatar, the home page URL
    - And I should see a search box
2. As a user on the home page,
    - When I tap on a user item
    - Then I should see the user's details
3. As a user on the item details page,
    - Then I should see user's home page loaded with the home page URL
4. As a user on the home page,
    - When I focus on to the search bar
    - And enter search terms
    - Then I should see the corresponding news result lists based on the search terms real time

### Functionality

- Use Swift >=4.2.
- Provide proper unit test.
- For API use this: https://api.github.com/search/users?q=swift, or similar.

### Bonus

- Write clear documentation on how it's designed and how to run the code.
- Write good in-code comments.
- Write good commit messages.

### Advanced requirements

*These are used for some further challenges. You can safely skip them if you are not asked to do any, but feel free to try out.*

- Apply the "SOLID" design.

## What We Care About

Feel free to use any open-source library if you see a good fit, but also remember that we're more interested in finding out your code skill and problem solving skill.

Here's what you should aim for:

- Good use of current Android & Swift best practices.
- We are usually interested in how you use Structs, Enums, Extensions, and Protocol Oriented Programming etc.
- Solid testing approach.
- Extensible code.

## FAQ

> Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think it's ready for review. You don't have to finish everything prior and you can continue work on it. We don't have a deadline for the task.

> What if I have a question?

Create a new issue in the repo and we will get back to you quickly.
