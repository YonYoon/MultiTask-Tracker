//
//  ToDoItem.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 26.07.2024.
//

import Foundation

struct ToDoItem {
    var name: String
    var isCompleted: Bool = false
    var id: UUID = UUID()
}

