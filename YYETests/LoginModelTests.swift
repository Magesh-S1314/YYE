//
//  LoginModelTests.swift
//  YYETests
//
//  Created by magesh on 23/04/21.
//

@testable import YYE
import XCTest

class LoginModelTests: XCTestCase {
    
    let validatorUtlity = UserInputValidatorUtlity()
    let user = UserModel(email: "test@gmail.com", passWord: "Test@1234")
    
    func test_is_valid_email() {
        XCTAssertTrue(validatorUtlity.isValidEmail(user.email))
    }
    
    func test_password_containsUppercase() {
        let passwordState = validatorUtlity.validate(user.passWord)
        XCTAssertTrue(passwordState.containsUppercase)
    }
    
    func test_password_containsLowercase() {
        let passwordState = validatorUtlity.validate(user.passWord)
        XCTAssertTrue(passwordState.containsLowercase)
    }
    
    func test_password_containsNumber() {
        let passwordState = validatorUtlity.validate(user.passWord)
        XCTAssertTrue(passwordState.containsNumber)
    }
    
    func test_password_containsSymbol() {
        let passwordState = validatorUtlity.validate(user.passWord)
        XCTAssertTrue(passwordState.containsSymbol)
    }
    
    func test_password_contains8To14Characters() {
        let passwordState = validatorUtlity.validate(user.passWord)
        XCTAssertTrue(passwordState.contains8To14Characters)
    }
}
