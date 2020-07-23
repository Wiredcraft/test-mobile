#  Design
### Flow logic
When the application start, it will make a network request to search user `Swift` as the initial Data show in homeView.

You can scroll up and down to refresh or load more data.

You can change search text to make a new request to search user. When change the keyword, it will wait for 500ms to confirm the keyword before searching.

### View layout
Use code to Layout, use SnapKit.

### Network
In this project, use `Moya` to abstract the network. Use Swift Foundation `Codable` to decode the json to Model.

### MVVM

This project is implemented with the MVVM pattern and heavy use of RxSwift, which makes binding very easy. But also make the code a little hard to understand.

The ViewModel performs pure transformation of a user Input to the Output
```
/**
 This protocol define standard the input stream and output stream of ViewModel
 */
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let searchTextTrigger: Driver<String>
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
        let userSelection: Driver<UserSectionItem>
    }
    
    struct Output {
        let items: BehaviorRelay<[UserSection]>
        let loading: PublishSubject<Bool>
        let userDisplay: Driver<UserDetailViewModel>
    }

}
```
`headerRefresh`&`footerRefresh`&`searchTextTrigger` will lead to data change and loading state.

`items` is used to output the data to View.

`loading` is used to dismiss fresh animation.

`userDisplay` as a result of user click.To show the user detail view.

I think it use RxSwift a bit heavy. It will be better to use RxSwift only for data binding.
