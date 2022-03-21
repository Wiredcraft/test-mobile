//
//  test_mobileTests.swift
//  test_mobileTests
//
//  Created by Jun Ma on 2022/3/21.
//

import XCTest
import Moya
import RxBlocking
@testable import test_mobile

class test_mobileTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Load data from local bundle
    func testLocalUsers() throws {
        let data = loadMockJsonData(for: "user_search_result")
        let endpoint = { [unowned self] (target: Network) -> Endpoint in
            self.mockEndpoint(for: target, response: .networkResponse(200, data))
        }
        
        let provider = MoyaProvider<Network>(
            endpointClosure: endpoint,
            stubClosure: MoyaProvider.delayedStub(1)
        ).rx
        
        do {
            let users = try provider.request(.searchUsers(keyword: "swift", page: 1))
                .toBlocking()
                .single()
                .map([User].self, atKeyPath: "items")
            XCTAssert(users.count > 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    /// Fetch user data over network
    func testNetworkSearchUsers() throws {
        let provider = MoyaProvider<Network>().rx
        do {
            let users = try provider.request(.searchUsers(keyword: "swift", page: 2))
                .toBlocking()
                .single()
                .map([User].self, atKeyPath: "items")
            XCTAssert(users.count > 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testLocalRepos() throws {
        let data = loadMockJsonData(for: "repos")
        let endpoint = { [unowned self] (target: Network) -> Endpoint in
            self.mockEndpoint(for: target, response: .networkResponse(200, data))
        }
        
        let provider = MoyaProvider<Network>(
            endpointClosure: endpoint,
            stubClosure: MoyaProvider.delayedStub(1)
        ).rx
        
        do {
            let repos = try provider.request(.repos(user: "swift"))
                .map([Repository].self)
                .toBlocking()
                .single()
            XCTAssert(repos.count > 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNetworkFetchRepos() throws {
        let provider = MoyaProvider<Network>().rx
        do {
            let repos = try provider.request(.repos(user: "swift"))
                .map([Repository].self)
                .toBlocking()
                .single()
            XCTAssert(repos.count > 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func mockEndpoint(for target: Network, response: Moya.EndpointSampleResponse) -> Endpoint {
        Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { response },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    func loadMockJsonData(for fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let filepath = bundle.path(forResource: fileName, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: filepath))
    }

}
