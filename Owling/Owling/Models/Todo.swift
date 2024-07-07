//
//  Todo.swift
//  Owling
//
//  Created by user228347 on 6/25/24.
//

import Foundation

struct Todo:Codable{
    var uid = UUID().uuidString
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
    print("saveTodo")
    let data = todoList.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: KeyForTodoList)
}

func loadTodoList() -> [Todo] {
    print("loadTodo")
    guard let encodedData = UserDefaults.standard.array(forKey: KeyForTodoList) as? [Data] else {
        return addTodoSample()
    }
    return encodedData.map { try! JSONDecoder().decode(Todo.self, from: $0) }
}

func deleteTodoList(){
    UserDefaults.standard.removeObject(forKey: KeyForTodoList)
}


func addTodoSample() -> [Todo]{
    
    print("Add sample")
    
        let today = Date()
        let plusOneHour = Calendar.current.date(byAdding: .hour, value: 1, to: today)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let afterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        let oneWeek = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        
        return [
            Todo(
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "IOS",color: .red),
                dueDate: plusOneHour,
                isImportant: true
            ),
            
            Todo(
                title: "Duis aute irure dolor in reprehenderit",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "IOS",color: .red),
                dueDate: tomorrow
            ),
            
            Todo(
                title: "Excepteur sint occaecat cupidatat non proident",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Web",color: .blue),
                dueDate: afterTomorrow
            ),
            
            Todo(
                title: "Duis aute irure dolor in reprehenderit",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Web",color: .blue),
                dueDate: afterTomorrow,
                isComplete: true
            ),
            
            Todo(
                title: "Lorem ipsum dolor sit amet",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Engineering and analysis of complex systems",color: .purple)
            ),
            
            
            Todo(
                title: "Excepteur sint occaecat cupidatat non proident",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Engineering and analysis of complex systems",color: .purple),
                dueDate: plusOneHour
            ),
            
            Todo(
                title: "Duis aute irure dolor in reprehenderit",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Engineering and analysis of complex systems",color: .purple),
                isImportant: true
            ),
            
            Todo(
                title: "Lorem ipsum dolor sit amet",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "Engineering and analysis of complex systems",color: .purple),
                dueDate: plusOneHour,
                isImportant: true
            ),
            
            Todo(
                title: "Excepteur sint occaecat cupidatat non proident",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            ),
            
            Todo(
                title: "Duis aute irure dolor in reprehenderit",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "IOS",color: .red),
                dueDate: tomorrow
            ),
            
            Todo(
                title: "Excepteur sint occaecat cupidatat non proident",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "IOS",color: .red),
                dueDate: afterTomorrow
            ),
            
            Todo(
                title: "Duis aute irure dolor in reprehenderit",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                category: Category(name: "IOS",color: .red),
                dueDate: oneWeek
            ),
            
        ]
    }
