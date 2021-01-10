//
//  UserPubiicationViewModelTests.swift
//  UserListTests
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import XCTest
@testable import UserList

class UserPubiicationViewModelTests: XCTestCase {
    
    func testGetUsername() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let user = UserModel(id: 1, name: "Test name", username: "Test username", email: "Test email", phone: "Test phone")
        let viewModel = UserPublicationViewModel(user: user, service: serviceMock)
        
        // When
        let result = viewModel.getUsername()
        // Then
        XCTAssertEqual(result, user.name + " Posts", "The result should be \(user.name)")
    }
    
    func testPublications() {
        // Given
        let serviceMock = ServiceFacadeMock()
        let user = UserModel(id: 1, name: "Test name", username: "Test username", email: "Test email", phone: "Test phone")
        let viewModel = UserPublicationViewModel(user: user, service: serviceMock)
        viewModel.retrievePublications()
        
        let expectedTitle = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
        let expectedBody = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        // Then
        guard let firstPublication = viewModel.publications.first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(viewModel.publications.count, 100, "The user under the id 1 has 100 publications")
        XCTAssertEqual(firstPublication.title, expectedTitle, "The title should be \(expectedTitle)")
        XCTAssertEqual(firstPublication.body, expectedBody, "The title should be \(expectedBody)")
    }
}
