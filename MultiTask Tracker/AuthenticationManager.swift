//
//  AuthenticationManager.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 26.07.2024.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated 
    case authenticating
    case authenticated
}
enum AuthenticationFlow {
    case login
    case signUp
}

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() { }
    
    var flow: AuthenticationFlow = .login
    
    var isValid = false
    var authenticationState: AuthenticationState = .unauthenticated
    var user: User?
}
