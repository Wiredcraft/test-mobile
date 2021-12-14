## GithubUser

A simple mvi architecture with compose.

 * use compose to build ui.
 * viewModel handle data, then generate state to compose.
 * use kotlin flow to subscribe state changes.

```
             intent
     ---------------------
    |                     |
    |                     |
    ↓        state        |
  viewModel ------->  compose
```
