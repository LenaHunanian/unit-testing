//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        // TODO: Implement test
        let expectation = self.expectation(description: "API call")
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(mockService.fetchUsersCallsCount, 1)
        
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        // TODO: Implement test
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        
        // TODO: Implement test
        let expectation = self.expectation(description: "result successful")
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertNil(sut.errorMessage)

    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        // TODO: Implement test
        mockService.fetchUsersResult = .failure(.invalidUrl)
        let sut = makeSut()
        let expectation = self.expectation(description: "error message for invalid url")
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        // TODO: Implement test
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()
        let expectation = self.expectation(description: "error message for unexpected failure")
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
        
        
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        // TODO: Implement test
        mockService.fetchUsersResult = .failure(.parsingError)
        let sut = makeSut()
        let expectation = self.expectation(description: "error message for invalid JSON parsing")
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        // TODO: Implement test
        mockService.fetchUsersResult = .success([
        User(id: 1, name: "Lena", username: "Hunanyan", email: "lena@email.com")
    ])
        let sut = makeSut()
        let expectation = self.expectation(description: "fetch and clean")
        
        sut.fetchUsers {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.users.count, 1)
        
        sut.clearUsers()
        XCTAssertEqual(sut.users.count, 0)
        
        
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}
