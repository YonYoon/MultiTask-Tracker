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
    var isCompleted: Bool = false
    var id: UUID = UUID()
}

/* var id: UUID = UUID()
 Объявляет свойство id типа UUID (уникальный идентификатор)
UUID - это тип данных, который генерирует уникальные идентификаторы, используемые для идентификации задач.
По умолчанию, при создании  ToDoItem  генерируется новый  UUID.
*/
