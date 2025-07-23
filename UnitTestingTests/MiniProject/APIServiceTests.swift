//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: - Fetch Users
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        // TODO: Implement test
        let sut = makeSut()
        let expectation = self.expectation(description: "Completion handler called")
        
        sut.fetchUsers(urlString: "invalid url") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidUrl)
            default:
                XCTFail("Expected .failure(.invalidUrl), got: \(result) instead")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        // TODO: Implement test
        let expectation = self.expectation(description: "Completion handler called")
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users.first?.name, "John Doe")
                expectation.fulfill()
            default:
                XCTFail("Expected .success(expectedUsers), got: \(result) instead")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        // TODO: Implement test
        let invalidJSON = """
    [
    {"id": "1", "invalidName": "missing real name" }
    ]
""".data(using: .utf8)
        mockURLSession.mockData = invalidJSON
        let sut = makeSut()
        let expectation = self.expectation(description: "Completion handler called")
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .parsingError)
                expectation.fulfill()
            default:
                XCTFail("expected .failure(.parsingError))")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        // TODO: Implement test
        mockURLSession.mockError = NSError(domain: "testError", code: -1)
        let sut = makeSut()
        let expectation = self.expectation(description: "Completion handler called")
        
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result{
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
                expectation.fulfill()
            default:
                XCTFail("expected .failure(.unexpected))")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    // MARK: - Fetch Users Async
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        // TODO: Implement test
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "invalid url")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidUrl)
        default:
            XCTFail("expected .failure(.invalidUrl))")
        }
    }
    
    // TODO: Implement test
    // add other tests for fetchUsersAsync
    
    // assert that method completes with .success()
    func test_apiService_fetchUsersAsync_whenValidResponse_returnsUsers() async {
        let json = """
    [
        { "id": 1, "name": "John", "username": "johnSmith", "email": "john@example.com" }
    ]
    """.data(using: .utf8)
        mockURLSession.mockData = json
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 1)
        default :
            XCTFail("expected .success(...)")
        }
    }
    //assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsersAsync_whenInvalidJson_returnsParsingError() async {
        let invalidJSON = "invalid json".data(using: .utf8)
        mockURLSession.mockData = invalidJSON
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .parsingError)
        default:
            XCTFail("expected .failure(.parsingError))")
        }
    }
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsersAsync_whenError_returnsUnexpectedError() async {
        mockURLSession.mockError = NSError(domain: "forTest", code: 500)
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .unexpected)
        default:
            XCTFail("expected .failure(.unexpected))")
        }
    }
    
    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
