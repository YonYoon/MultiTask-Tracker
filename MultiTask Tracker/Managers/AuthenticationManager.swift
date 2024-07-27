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
    
    func signInWith(email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print(error)
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signUpWith(email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print(error)
            authenticationState = .unauthenticated
            return false
        }
    }
}
