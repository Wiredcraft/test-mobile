# Mobile Test - GitHub Users List App

Make sure you read the whole document carefully and follow the guidelines in it.

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
    - Then I should see the corresponding new result lists based on the search terms real time
5. As a user on the home page,
	- When I pull the list down
	- And the list reach Top
	- Then I should see the list refresh
6. As a user on the home page,
	- When I scroll up
	- And the list reach bottom
	- Then I should be able continue scrolling to see next page's data

### Functionality

- Use Swift >=4.2 for iOS.
- Use Kotlin >=1.3 for Android.
- Provide proper unit tests.
- For API use this: https://api.github.com/search/users?q=swift&page=1, or similar.

### Bonus

- Write clear documentation on how it's designed and how to run the code.
- Write good in-code comments.
- Write good commit messages.

### Advanced requirements

*These are used for some further challenges. You can safely skip them if you are not asked to do any, but feel free to try out.*

- Apply the "SOLID" design for iOS.
- Apply the Material design for Android.

## What We Care About

Feel free to use any open-source library as you see fit, but remember that we are evaluating your coding skills and problem solving skills.

Here's what you should aim for:

- Good use of current Android & Swift best practices.
- We are usually interested in how you use Structs, Enums, Extensions, and Protocol Oriented Programming etc.
- Good testing approach.
- Extensible code.

## FAQ

> Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think it's ready for review. You don't have to finish everything prior and you can continue to work on it. We don't have a deadline for the task.

> What if I have a question?

Create a new issue in the repo and we will get back to you shortly.
