//
//  TodoFormViewController.swift
//  Owling
//
//  Created by user228347 on 7/1/24.
//

import UIKit
import SwiftUI

class TodoFormViewController: UIViewController {
    
    @IBOutlet weak var buttonSelectCategory: UIButton!
    
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textDescription: UITextField!
    
    
    
    @IBOutlet weak var switchImportant: UISwitch!
    
    
    @IBOutlet weak var buttonAction: UIButton!
    
    var settings:Settings = loadSettings()
    
    //Start Select category
    let transparentView = UIView()
    
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var categories = [Category]()
    //End select category
    
    //Start due date
    @IBOutlet weak var textDueDate: UITextField!
    
    let datePicker = UIDatePicker()
    //End due date
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSample()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        
        
        createDatepicker()
    }
    
    func addSample(){
        self.categories = [
            Category(),
            Category(name:"IOS",color:.red),
            Category(name:"Web",color: .blue)
        ]
    }
    
    
    //Start category
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        //Add tableView
        tableView.frame = CGRect(x: frames.origin.x,
                                 y: frames.origin.y + frames.height,
                                 width: frames.width,
                                 height: 0)
        tableView.layer.cornerRadius = 5
        self.view.addSubview(tableView)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        //Animeation
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x,
                                          y: frames.origin.y + frames.height + 5,
                                          width: frames.width,
                                          height: CGFloat(self.categories.count*50))

        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            let frames = self.selectedButton.frame
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x,
                                          y: frames.origin.y + frames.height,
                                          width: frames.width,
                                          height: 0)

        }, completion: nil)
    }

    @IBAction func SelectCategory(_ sender: Any) {
        self.selectedButton = buttonSelectCategory
        addTransparentView(frames: buttonSelectCategory.frame)
    }
    
    //End Category
    
    
    //Start due date
    func createDatepicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        textDueDate.inputView = datePicker
        textDueDate.inputAccessoryView = createToolbar()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([btnDone], animated: true)
        
        return toolbar
    }
    
    @objc func donePressed() {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = settings.defaultDateFormat
        
        self.textDueDate.text = dataFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    //End due date
    
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
       //Validar se 'e null
        let title = textTitle.text
        let description = textDescription.text ?? ""
        let category = Category(name: buttonSelectCategory.titleLabel?.text ?? categoryDefaultName, color: Color(buttonSelectCategory.backgroundColor ?? .white))
        let dueDateText = textDueDate.text ?? ""
        let isImportant = switchImportant.isOn
        
        var todo:Todo
        
        if dueDateText == "" {
            todo = Todo(title: title!, description: description, category: category, isImportant: isImportant)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = settings.defaultDateFormat
            let dueDate = dateFormatter.date(from:dueDateText)!
            todo = Todo(title: title!, description: description, category: category, dueDate: dueDate, isImportant: isImportant)
        }
                
        if let vc = storyboard?.instantiateViewController(identifier: "taskList") as? ViewController {
            vc.addNewTodo(todo)
            vc.viewDidLoad()
        }
        self.tabBarController!.selectedIndex = 0
        print("OK")
        
    }
    
    
}


extension TodoFormViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        var category = categories[indexPath.row]
//        print(indexPath.row)

        cell.textLabel?.text = category.name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TodoFormViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = self.categories[indexPath.row]
        buttonSelectCategory.setTitle(category.name, for: .normal)
        buttonSelectCategory.backgroundColor = category.color.uiColor()
        removeTransparentView()
    }
}
