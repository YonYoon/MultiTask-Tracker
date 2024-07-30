//
//  FileManager.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 30.07.2024.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    static private let url: URL = {
        // Получение пути к директории "Documents"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("toDo.data")
    }()
    
    func read() -> [ToDoItem] {
        do {
            let data = try Data(contentsOf: PersistenceManager.url)
            let list = try JSONDecoder().decode([ToDoItem].self, from: data)
            return list
        } catch {
            print("Error reading data: (error)")
            return [] // Возвращаем пустой массив, если не удалось прочитать
        }
    }
    
    func write(list: [ToDoItem]) {
        do {
            let data = try JSONEncoder().encode(list)
            try data.write(to: PersistenceManager.url)
            print("Successfully written")
        } catch {
            print("Error writing data: (error)")
        }
    }
}
