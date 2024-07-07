//
//  ViewController.swift
//  Owling
//
//  Created by user228347 on 6/25/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var todoList:[Todo] = loadTodoList()
    var groupedTodos: [String: [Todo]] = [:]
    var categoryKeys: [String] = []
    
    var settings:Settings = loadSettings()
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    
    
    func reload() {
        print("Call Reload")
        
        // Carregar configurações
        self.settings = loadSettings()
        self.todoList = loadTodoList()
        

        // Agrupar tarefas por categoria
        self.groupedTodos = Dictionary(grouping: loadTodoList(), by: { $0.category.name })
        categoryKeys = groupedTodos.keys.sorted()
        self.tableView?.reloadData()
        
    }
    
    
    func addNewTodo(_ newTodo: Todo) {
        self.todoList.append(newTodo)
        saveTodoList(self.todoList)
        
        tableView.beginUpdates()

        var newIndexPath = IndexPath(row: todoList.count - 1, section: 0)

        if self.settings.grupedByCategory {
            if let sectionIndex = categoryKeys.firstIndex(of: newTodo.category.name) {
                if var todosInCategory = groupedTodos[newTodo.category.name] {
                    todosInCategory.append(newTodo)
                    groupedTodos[newTodo.category.name] = todosInCategory
                    newIndexPath = IndexPath(row: todosInCategory.count - 1, section: sectionIndex)
                }
            }
        }

        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.endUpdates()
        tableView.reloadData()
    }
}





extension ViewController:UITableViewDataSource{
    
    //Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.settings.grupedByCategory {
            return categoryKeys.count
        }
        return 1
    }
    
    //Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        if self.settings.grupedByCategory {
            let category = self.categoryKeys[section]
            return self.groupedTodos[category]?.count ?? 0
        }
        return todoList.count
    }
    
    //Return section title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.settings.grupedByCategory {
            if categoryKeys[section] == categoryDefaultName {
                return categoryDefaultValeu
            }
            return categoryKeys[section]
        }
        return ""
    }
    
    //Add content in the rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        // add border and color
        
        if self.settings.grupedByCategory {
            let category = categoryKeys[indexPath.section]
            if let todo = groupedTodos[category]?[indexPath.row] {
                cell.set(todo: todo)
            }
        } else {
            let todo:Todo = todoList[indexPath.row]
            cell.set(todo: todo)
        }
        return cell
    }
    
    // On click show task info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TodoView") as? TodoViewController {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = settings.defaultDateFormat
       
            let todo:Todo
            if settings.grupedByCategory {
                let category = categoryKeys[indexPath.section]
                todo = groupedTodos[category]![indexPath.row]
            } else {
                todo = todoList[indexPath.row]
            }
            
            vc.showTitle = todo.title
            vc.showDescription = todo.description
            vc.showDueDate = dateFormatter.string(from:todo.dueDate)
            vc.showCreateAt = dateFormatter.string(from:todo.createAt)
            vc.showCompleteAt = dateFormatter.string(from:todo.completedAt)
            vc.isImportant = todo.isImportant
            vc.isComplete = todo.isComplete
            vc.category = todo.category
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
    }
}



extension ViewController: UITableViewDelegate{
    
    //Remove Task
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        if settings.grupedByCategory {
            let category = categoryKeys[indexPath.section]
            guard var todosInCategory = groupedTodos[category] else { return }
            todosInCategory.remove(at: indexPath.row)
            if todosInCategory.isEmpty {
                self.groupedTodos.removeValue(forKey: category)
                self.categoryKeys = self.groupedTodos.keys.sorted()
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }else{
                self.groupedTodos[category] = todosInCategory
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        } else {
            todoList.remove(at: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        saveTodoList(todoList)
        tableView.endUpdates()
    }
    
    
    //Complete Task
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
            tableView.beginUpdates()
            if self.settings.grupedByCategory {
                let category = self.categoryKeys[indexPath.section]
                let todo:Todo = (self.groupedTodos[category]?[indexPath.row])! as Todo
                print("Todo: \(todo)")
                print("--------------------------")
                print(self.todoList)
                let id = self.todoList.firstIndex(where: {$0.title == todo.title});
                
                print("ID: \(id)")
                if id != nil {
                    self.todoList[id!].completedAt = Date()
                    self.todoList[id!].isComplete = true;
                }
            } else {
                self.todoList[indexPath.row].completedAt = Date()
                self.todoList[indexPath.row].isComplete = true;
            }
            saveTodoList(self.todoList)
            self.reload()
            tableView.endUpdates()
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
