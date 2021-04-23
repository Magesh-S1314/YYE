//
//  UserInputValidatorUtlity.swift
//  YYE
//
//  Created by magesh on 23/04/21.
//

import Foundation

struct PasswordValidatorState {
    var containsUppercase = false
    var containsLowercase = false
    var containsSymbol = false
    var containsNumber = false
    var contains8To14Characters = false
    
    func allSatisfy() -> Bool {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let value = child.value as? Bool, value else { return false }
        }
        return true
    }
}

enum ValidationError: LocalizedError {
    case invalidEmail
    case passwordShouldContainsUppercase
    case passwordShouldContainsLowercase
    case passwordShouldContainsSymbol
    case passwordShouldContainsNumber
    case passwordShould8To14Characters
    case enterRequiredData
    
    var errorDescription: String?{
        switch self{
        case .invalidEmail:
            return "Enter a valid email"
        case .passwordShouldContainsUppercase:
            return "Password should contain uppercase"
        case .passwordShouldContainsLowercase:
            return "Password should contain lowercase"
        case .passwordShouldContainsSymbol:
            return "Password should contain special character"
        case .passwordShouldContainsNumber:
            return "Password should contain number"
        case .passwordShould8To14Characters:
            return "Password must be 8 to 14 characters"
        case .enterRequiredData:
            return "Please enter all mandatory data"
        }
    }
}

struct UserInputValidatorUtlity {
    //This struct is built on top of functional programming paradigm to keep validation simple and scalable.
    
    private func satisfy(for input: String, regex: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: input)
    }

    private func containsUppercase(state: PasswordValidatorState, string: String) -> PasswordValidatorState {
        var localState = state
        let containsUppercase = satisfy(for: string, regex: ".*[A-Z].*")
        localState.containsUppercase = containsUppercase
        return localState
    }

    private func containsLowercase(state: PasswordValidatorState, string: String) -> PasswordValidatorState {
        var localState = state
        let containsLowercase = satisfy(for: string, regex: ".*[a-z].*")
        localState.containsLowercase = containsLowercase
        return localState
    }
    
    private func containsSymbol(state: PasswordValidatorState, string: String) -> PasswordValidatorState {
        var localState = state
        let containsSymbol = satisfy(for: string, regex: #".*[!&^%$#@\(\)\/\\].*"#)
        localState.containsSymbol = containsSymbol
        return localState
    }
    
    private func containsNumber(state: PasswordValidatorState, string: String) -> PasswordValidatorState {
        var localState = state
        let containsNumber = satisfy(for: string, regex: ".*[0-9].*")
        localState.containsNumber = containsNumber
        return localState
    }
    
    private func contains8To14Characters(state: PasswordValidatorState, string: String) -> PasswordValidatorState {
        var localState = state
        let contains8To14Characters = satisfy(for: string, regex: ".{8,14}")
        localState.contains8To14Characters = contains8To14Characters
        return localState
    }


    func validate(_ input: String) -> PasswordValidatorState {
        
        let initialState = PasswordValidatorState()
        //functional programming pipeline
        let pipeline = [containsUppercase, containsLowercase, containsSymbol, containsNumber,contains8To14Characters]
        let finalState = pipeline.reduce(initialState) { (state, function) in
            function(state, input)
        }
        return finalState
    }

    func isValidEmail(_ input: String) -> Bool {
        return satisfy(for: input, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
}
