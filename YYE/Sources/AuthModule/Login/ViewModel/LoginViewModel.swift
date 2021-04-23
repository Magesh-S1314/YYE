//
//  LoginViewModel.swift
//  YYE
//
//  Created by magesh on 23/04/21.
//

import Foundation

typealias ValidationSatus = (status: Bool, error: ValidationError?)

class LoginViewModel {
    
    private let validatorUtlity: UserInputValidatorUtlity?
    private var user: UserModel?
    
    init() {
        validatorUtlity = UserInputValidatorUtlity()
        user = UserModel(email: nil, passWord: nil)
    }
    
    func setValue(value: String, isEmail: Bool) {
        if isEmail {
            user?.email = value
        }else{
            user?.passWord = value
        }
    }
    
    private func isValidEmail() -> Bool {
        return validatorUtlity?.isValidEmail((user?.email)!) ?? false
    }
    
    private func isValidPassword() -> ValidationSatus {
        let validatedPassword = validatorUtlity?.validate((user?.passWord)!)
        
        if !validatedPassword!.containsUppercase {
            return ValidationSatus(status: false, error: .passwordShouldContainsUppercase)
        }else if !validatedPassword!.containsLowercase{
            return ValidationSatus(status: false, error: .passwordShouldContainsLowercase)
        }else if !validatedPassword!.containsSymbol{
            return ValidationSatus(status: false, error: .passwordShouldContainsSymbol)
        }else if !validatedPassword!.containsNumber{
            return ValidationSatus(status: false, error: .passwordShouldContainsNumber)
        }else if !validatedPassword!.contains8To14Characters{
            return ValidationSatus(status: false, error: .passwordShould8To14Characters)
        }
        
        return ValidationSatus(status: true, error: nil)
    }
    
    func validate() -> ValidationSatus {
        guard let user = user, (user.email != nil), (user.passWord != nil) else {
            return ValidationSatus(status: false, error: .enterRequiredData)
        }
        guard isValidEmail() else {
            return ValidationSatus(status: false, error: .invalidEmail)
        }
        return isValidPassword()
    }
}
