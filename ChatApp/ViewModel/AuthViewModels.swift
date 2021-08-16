//
//  AuthViewModels.swift
//  ChatApp
//
//  Created by SWE-PC-110 on 2021-08-10.
//

import Foundation

protocol AuthenticationProtocol {
    var isValidInput: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var isValidInput: Bool {
        return email?.isEmpty == false &&
               password?.isEmpty == false
    }
  
}

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var username: String?
    
    var isValidInput: Bool {
        return email?.isEmpty == false &&
               password?.isEmpty == false &&
               firstName?.isEmpty == false &&
               lastName?.isEmpty == false &&
               username?.isEmpty == false
    }
}

enum AccountInfoViewModel: Int, CaseIterable {
    case personalInfo
    case settings

    var title: String {
        switch self {
        case .personalInfo:
            return "Personal info"
        case .settings:
            return "Settings"
        }
    }
    var imageName: String {
        switch self {
        case .personalInfo:
            return "person.circle"
        case .settings:
            return "gearshape.fill"
        }
    }
    
    
}
