//
//  SettingsOption.swift
//  Owling
//
//  Created by user228347 on 6/27/24.
//

import Foundation
import UIKit

struct SettingsOption {
    var title:String
    var icon:UIImage? = nil
    var iconBackgroundColor: UIColor? = nil
    var isASwitch: Bool = false
    var isOn: Bool = false
    var handler: (()->Void)
}

struct Section{
    let title:String
    let options: [SettingsOption]
}
