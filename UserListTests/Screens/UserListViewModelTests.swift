//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import XCTest
@testable import UserList

class UserListViewModelTests: XCTestCase {
    
    private enum ExpectedResults {
        static let username = "Leanne Graham"
        static let userId = 1
        static let email = "Sincere@april.biz"
        static let phone = "1-770-736-8031 x56442"
    }
    
    func testFilterUser_givenUsername_shouldReturnOneMatch() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let viewModel = UserListViewModel(service: serviceMock)
        viewModel.fetchUsers()
        
        // When
        viewModel.filterUser(by: ExpectedResults.username)
        
        // Then
        XCTAssertEqual(viewModel.users.count, 1, "There is only one user that fulfills that filter")
    }
    
    func testFilterUser_givenNoInput_shouldReturnOneMatch() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let viewModel = UserListViewModel(service: serviceMock)
        viewModel.fetchUsers()
        
        // When
        viewModel.filterUser(by: "")
        
        // Then
        XCTAssertEqual(viewModel.users.count, 10, "There are 10 users cached")
    }
    
    func testUserData() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let viewModel = UserListViewModel(service: serviceMock)
        viewModel.fetchUsers()
        
        // When
        viewModel.filterUser(by: ExpectedResults.username)
        
        // Then
        guard let user = viewModel.users.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(user.id, ExpectedResults.userId, "The id should be \(ExpectedResults.userId)")
        XCTAssertEqual(user.name, ExpectedResults.username, "The name should be \(ExpectedResults.username)")
        XCTAssertEqual(user.phone, ExpectedResults.phone, "The phone should be \(ExpectedResults.phone)")
        XCTAssertEqual(user.email, ExpectedResults.email, "The email should be \(ExpectedResults.email)")
    }
}
