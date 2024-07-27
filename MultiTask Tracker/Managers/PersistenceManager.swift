//
//  PersistenceManager.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 25.07.2024.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    static private let url = URL.documentsDirectory.appending(path: "friends.data")
    
    func read() -> [MTUser] {
        do {
            let data = try Data(contentsOf: PersistenceManager.url)
            let friends = try JSONDecoder().decode([MTUser].self, from: data)
            return friends
        } catch {
            print(error)
            return []
        }
    }
    
    func write(friends: [MTUser]) {
        do {
            let data = try JSONEncoder().encode(friends)
            try data.write(to: PersistenceManager.url)
            print("succesfully written")
        } catch {
            print(error)
        }
    }
}
