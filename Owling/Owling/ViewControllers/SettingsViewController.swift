//
//  SettingsViewController.swift
//  Owling
//
//  Created by user228347 on 6/27/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var appInfo: UITextView!
    
    var models : [Section] = [Section]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    
        let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

        appInfo.text = "\(appName) (\(appVersion!))\nBy Rodrigo Bruner"
        
    }
    
  
    func config(){
        models.append(Section(title: "Presentation", options: [
            SettingsOption(title: "Order by date due", icon: UIImage(systemName: "date"), iconBackgroundColor: .red, handler: {
                    print("01")
            }),
            SettingsOption(title: "Order by category", icon: UIImage(systemName: "house"), iconBackgroundColor: .red, isASwitch:true, isOn:true, handler: {
                print("02")
            }),
        ]))
        
        models.append(Section(title: "List", options: [
            SettingsOption(title: "Order by date due", icon: UIImage(systemName: "date"), iconBackgroundColor: .red, handler: {
                print("03")
            }),
           SettingsOption(title: "Order by category", icon: UIImage(systemName: "house"), iconBackgroundColor: .red,  isASwitch:true, isOn:false, handler: {
                print("04")
            }),
        ]))
    }
}



extension SettingsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = models[indexPath.section].options[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "settingsCell",
            for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.set(option: option)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
}

extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = models[indexPath.section].options[indexPath.row]
        option.handler()
    }
}
