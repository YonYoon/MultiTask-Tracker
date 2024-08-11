//
//  ToDoItem.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 26.07.2024.
//

import Foundation

// Codable - это протокол, который делает структуру доступной для кодирования (преобразования в JSON) и декодирования (преобразования из JSON) данных.

struct ToDoItem: Codable {
    var name: String
    var completed: Bool = false
    var id: UUID

    init(name: String) {
        self.name = name
        self.id = UUID() // Создаем UUID при инициализации
        self.completed = false
    }
}

/* var id: UUID = UUID()
 Объявляет свойство id типа UUID (уникальный идентификатор)
UUID - это тип данных, который генерирует уникальные идентификаторы, используемые для идентификации задач.
По умолчанию, при создании  ToDoItem  генерируется новый  UUID.
*/
