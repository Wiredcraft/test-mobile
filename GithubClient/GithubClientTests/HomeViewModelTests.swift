//
//  HomeViewModelTests.swift
//  GithubClientTests
//
//  Created by Apple on 2020/7/22.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import XCTest
import Moya
import RxSwift
import RxCocoa

class HomeViewModelTests: XCTestCase {

    var provider: MoyaProvider<GitHub>!
    var refreshTrigger: PublishSubject<Void>!
    var footerTrigger: PublishSubject<Void>!
    var searchText: BehaviorRelay<String>!
    var selectionItem: PublishSubject<Int>!
    var searchResult: GithubSearchResult!
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        provider = MoyaProvider<GitHub>(stubClosure: MoyaProvider.immediatelyStub)
        self.refreshTrigger = PublishSubject<Void>()
        self.footerTrigger = PublishSubject<Void>()
        self.searchText = BehaviorRelay<String>(value: "Swift")
        self.selectionItem = PublishSubject<Int>()
        
        let url = Bundle.main.url(forResource: "users", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(GithubSearchResult.self, from: data!) else {
            return
        }
        self.searchResult = result
        self.viewModel = HomeViewModel(self.provider)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModel() throws {
        let expection = XCTestExpectation(description: "data change")
        expection.expectedFulfillmentCount = 8
        let input = HomeViewModel.Input(searchTextTrigger: self.searchText.asDriver(),
                                        headerRefresh: self.refreshTrigger,
                                        footerRefresh: self.footerTrigger,
                                        userSelection: selectionItem.map({ (i) -> UserSectionItem in
                                            return UserSectionItem.user(cellViewModel: UserCellViewModel(self.searchResult.items[i]))
                                        }).asDriver(onErrorJustReturn: UserSectionItem.user(cellViewModel: UserCellViewModel(self.searchResult.items[22]))
                                        ))
        let output = self.viewModel.transform(input)
        self.refreshTrigger.onNext(())

        var index = 0
        let countResult = [30,30,30,60,30,30,60]


        output.items.asObservable().subscribe { (event) in

            switch event {
            case .next(let sections):
                if sections.count == 1 {
                    XCTAssert(sections[0].items.count == countResult[index], "data error")
                    expection.fulfill()
                    index += 1
                }
            default:
                break
            }
        }.disposed(by: self.disposeBag)
    
        output.userDisplay.asObservable().subscribe(onNext: { (userDetailViewModel) in
            print(userDetailViewModel)
            XCTAssert(userDetailViewModel.title == "swift", "selection error")
            expection.fulfill()
        }).disposed(by: self.disposeBag)


        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(i)) {
                switch i % 3 {
                case 0:
                    print("searchText")
                    self.searchText.accept("\(i)")
                case 1:
                    print("footer Trigger")
                    self.footerTrigger.onNext(())
                    self.selectionItem.onNext(0)
                case 2:
                    print("refresh Trigger")
                    self.refreshTrigger.onNext(())
                default:
                    break
                }
            }
        }

        self.wait(for: [expection], timeout: 10)

        
        
    }
}
