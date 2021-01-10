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
        static let user = "Sincere@april.biz"
        static let phone = "1-770-736-8031 x56442"
    }
    
    func testSomething() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let viewModel = UserListViewModel(service: serviceMock)
        viewModel.fetchUsers()
        
        // When
        viewModel.filterUser(by: "Leanne")
        
        // Then
        XCTAssertEqual(viewModel.displayedUsers.count, 1, "There is only one user that fulfills that filter")
    }
}
