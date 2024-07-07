//
//  Category.swift
//  Owling
//
//  Created by user228347 on 6/25/24.
//

import Foundation
import UIKit
import SwiftUI

let categoryDefaultName = "Select a category"
let categoryDefaultValeu = "Uncategorized"

struct Category: Codable{
    var name:String = categoryDefaultName
    var color:Color = .white
}


let KeyForCategories = "categories"

func saveCategories(_ categories: [Category]) {
    let data = categories.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: KeyForCategories)
}

func loadCategories() -> [Category] {
    guard let encodedData = UserDefaults.standard.array(forKey: KeyForCategories) as? [Data] else {
        return []
    }
    
    return encodedData.map { try! JSONDecoder().decode(Category.self, from: $0) }
}
