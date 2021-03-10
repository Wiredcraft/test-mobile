## Design

### 1. ViewModel
* the GULViewModelProtocol define the interface for viewmodel

```
// define viewmodel interface
protocol GULViewModelProtocol {
    associatedtype Input // inpout object type
    associatedtype Output // output object type
    
    // input transform to output
    func transform(input: Input) -> Output
}
```

* In this demo, the GULUsersListViewModel declare the Input is GULUsersListInput and Output is GULUsersListOutput. The GULUsersListInput has thress properties. They are search, headerRefresh and footerRefresh. The GULUsersListOutput has two properties. they are usersItems and refreshState. 

```
class GULUsersListViewModel: GULViewModelProtocol {
    
    typealias Input = GULUsersListViewModel.GULUsersListInput
    
    typealias Output = GULUsersListViewModel.GULUsersListOutput
    
    struct GULUsersListInput {
        let search: BehaviorRelay<String>
        let headerRefresh: PublishRelay<Void>
        let footerRefresh: PublishRelay<Void>
    }
    
    struct GULUsersListOutput {
        let usersItems: BehaviorRelay<[GULUserItemViewModel]> // cell viewmdoel
        let refreshState: BehaviorRelay<GULRefreshState> // control of header refresh and footer refresh
    }
    
    ......
}
```

* Through `transform(input: Input) -> Output`, the GULUsersListInput is transformed to the GULUsersListOutput which give to tableview and cell.

## 2. GULUsersListViewController
* In the GULUsersListViewController, there are three Observable.
The `searchBehavior` observe input text of search bar.
The `headerTrigger ` observe the tableview header refresh control.
The `footerTrigger ` observe the tableview footer refresh control

```
class GULUsersListViewController: UIViewController {
    private lazy var searchBehavior: BehaviorRelay<String> = BehaviorRelay<String>(value: "swift")
    private lazy var headerTrigger: PublishRelay<Void> = PublishRelay<Void>()
    private lazy var footerTrigger: PublishRelay<Void> = PublishRelay<Void>()
    
    ......
}
```

* Create `GULUsersListInput` with the three Observable, and send it to the viewmodel. Then the viewmodel output the `GULUsersListOutput` for GULUsersListViewController to use.

```
let input = GULUsersListViewModel.GULUsersListInput(search: searchBehavior,
                                                            headerRefresh: headerTrigger,
                                                            footerRefresh: footerTrigger)
let output = viewModel.transform(input: input)
    
output.usersItems
    .bind(to: tableView.rx.items(cellIdentifier: GULUsersListCell.reuseIdentifier(), cellType: GULUsersListCell.self)){row, post, cell in
        cell.bind(viewModel: post)
    }.disposed(by: disposeBag)
    
output.refreshState
    .subscribe(onNext: { [weak self] (state) in
        switch state {
        case .endFooterRefresh:
            self?.tableView.mj_footer?.endRefreshing()
        case .endHeaderRefresh:
            self?.tableView.mj_header?.endRefreshing()
        default:
            break
        }
    }).disposed(by: disposeBag)
```