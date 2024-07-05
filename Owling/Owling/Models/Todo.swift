//
//  Todo.swift
//  Owling
//
//  Created by user228347 on 6/25/24.
//

import Foundation

struct Todo:Codable{
    let title: String
    let description: String
    var category: Category = Category(name: categoryDefaultName, color: .white)
    var createAt: Date = Date()
    var completedAt: Date = Date()
    var dueDate: Date = Date()
    var isComplete: Bool = false
    var isImportant: Bool = false
}

let KeyForTodoList = "todoList"

func saveTodoList(_ todoList: [Todo]) {
    let data = todoList.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: KeyForTodoList)
}

func loadTodoList() -> [Todo] {
    guard let encodedData = UserDefaults.standard.array(forKey: KeyForTodoList) as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(Todo.self, from: $0) }
}

func deleteTodoList(){
    UserDefaults.standard.removeObject(forKey: KeyForTodoList)
}
