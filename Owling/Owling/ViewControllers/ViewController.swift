//
//  ViewController.swift
//  Owling
//
//  Created by user228347 on 6/25/24.
//

import UIKit

class ViewController: UIViewController {
        
    var todoList:[Todo] = []
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if self.tableView.isScrollEnabled {
            self.tableView.verticalScrollIndicatorInsets =  UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -8);
        }
        
        addSample()
//        deleteTodoList()
        
        let start: [Todo] = loadTodoList()
        if(start.count > 0){
            self.todoList = start
        }
    }
    
    func addSample(){
        
        let today = Date()
        let plusOneHour = Calendar.current.date(byAdding: .hour, value: 1, to: today)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let afterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        let oneWeek = Calendar.current.date(byAdding: .day, value: 7, to: today)!

        
        self .todoList = [
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
    
    
}





extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        // add border and color
        
        let todo:Todo = todoList[indexPath.section]
        cell.set(todo: todo)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "TodoView") as? TodoViewController {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = defaultDateFormat
       
            vc.showTitle = todoList[indexPath.section].title
            vc.showDescription = todoList[indexPath.section].description
            vc.showDueDate = dateFormatter.string(from:todoList[indexPath.section].dueDate)
            vc.showCreateAt = dateFormatter.string(from:todoList[indexPath.section].createAt)
            vc.showCompleteAt = dateFormatter.string(from:todoList[indexPath.section].completedAt)
            vc.isImportant = todoList[indexPath.section].isImportant
            vc.isComplete = todoList[indexPath.section].isComplete
            vc.category = todoList[indexPath.section].category
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
    }
}



extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteSections(IndexSet([indexPath.section]), with: .none)
        todoList.remove(at: indexPath.section)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveTodoList(todoList)
        tableView.endUpdates()
    }
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
              tableView.beginUpdates()
              self.todoList[indexPath.section].completedAt = Date()
              saveTodoList(self.todoList)
              tableView.endUpdates()
          }
          
          return UISwipeActionsConfiguration(actions: [action])
    }
}
