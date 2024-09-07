//
//  NetworkManager.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 07.09.2024.
//

import Foundation
import FirebaseFirestore

class NetworkManager {
    static let shared = NetworkManager()
    private let db = Firestore.firestore()
    
    private init() { }
    
    func getUser(withName name: String) async -> MTUser! {
        do {
            let querySnapshot = try await db.collection("users").whereField("name", isEqualTo: name).getDocuments()
            
            let userDocument = querySnapshot.documents.first
            if let documentId = userDocument?.documentID {
                let user = try await db.collection("users").document(documentId).getDocument(as: MTUser.self)
                return user
            }
            
            return nil
        } catch {
            print("Query failed")
            return nil
        }
    }
}
