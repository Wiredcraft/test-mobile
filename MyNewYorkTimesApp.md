# Mobile Test - My New York Times App

## User Stories

1. As a user on app first launch,
  - When I reach the home page
  - Then I should see a list (or gallery of news headlines). Each news item on this page should show: title, snippet, date, image
  - And I should see a search box
2. As a user on the home page,
  - When I tap on a news item
  - Then I should see the news details
3. As a user on the news details page,
  - When I swipe left or right
  - Then I should see the corresponding news before or after the current news item based on the order on the home page
4. As a user on the home page,
  - When I focus on to the search bar
  - And enter search terms
  - And press enter
  - Then I should see the corresponding news result lists based on the search terms
5. As a user at the home page,
  - When I tap and focus into the search box
  - Then I should see a list of my previous 10 search terms
6. As a user at the home page with previous search terms shown,
  - When I select a search term item
  - Then I should see the corresponding news result lists based on the selected search term
7. As a user on the home page with news list shown,
  - When I scroll near the end of the list,
  - Then the next page should be loaded (aka. “infinite scroll”)

## API

- You can use the example: https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=5538c097a2294a399fbe7904bb61db1c&q=shanghai&page=0
- Or you can create your own API key via https://developer.nytimes.com/


## Requirements

1. Swift >=3.0. We are usually interested in how you use Structs, Enums, Extensions, and Protocol Oriented Programming etc.
2. Please limit the use of 3rd party libraries.
3. Apply the SOLID design if possible.
4. A solid testing approach and a good coverage.
5. A clear document.
