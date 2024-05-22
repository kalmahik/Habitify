//
//  LoginModel.swift
//  Habitify
//
//  Created by kalmahik on 22.05.2024.
//

import Foundation

final class CategoryModel {
    
    private let requiredCredentialLength = 4
    private(set) var isUserLoggedIn = false
        
    func didEnter(_ credentials: Credentials) -> Result<Bool, Error> {

        do {
            try validate(credentials.login)
            try validate(credentials.password)
            
        } catch {
            return .failure(error)
        }

        let isLoginAllowed = isLoginAllowed(for: credentials)
        return .success(isLoginAllowed)
    }
    
    private func validate(_ string: String?) throws {
        
        guard let string = string else { return }
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            throw LoginError.invalidCharacter
        }
        
        if string.count > requiredCredentialLength {
            throw LoginError.longString
        }
    }
    
    private func isLoginAllowed(for credentials: Credentials) -> Bool {
        
        guard let login = credentials.login,
              let password = credentials.password,
              login.count == requiredCredentialLength,
              password.count == requiredCredentialLength
        else {
            return false
        }
        
        let allowedLoginCharacters = CharacterSet(charactersIn: "02468")
        let allowedPasswordCharacters = CharacterSet(charactersIn: "13579")
        
        let loginCharacters = CharacterSet(charactersIn: login)
        let passwordCharacters = CharacterSet(charactersIn: password)
        
        return allowedLoginCharacters.isSuperset(of: loginCharacters) &&
            allowedPasswordCharacters.isSuperset(of: passwordCharacters)
    }
}
