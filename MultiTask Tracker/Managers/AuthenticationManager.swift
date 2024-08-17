//
//  AuthenticationManager.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 26.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

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
    private let db = Firestore.firestore()
    
    private init() { }
    
    var flow: AuthenticationFlow = .login
    
    var isValid = false
    var authenticationState: AuthenticationState = .unauthenticated
    var user: User?
    
    var authStateHandle: AuthStateDidChangeListenerHandle?
    
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
    
    func signUpWith(username: String, email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            try await changeRequest?.commitChanges()
            
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            
            try await db.document("users/\(authResult.user.uid)").setData([
                "name": username,
                "email": email,
            ])
            
            return true
        } catch {
            print(error)
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
