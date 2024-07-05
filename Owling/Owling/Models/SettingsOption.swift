//
//  SettingsOption.swift
//  Owling
//
//  Created by user228347 on 6/27/24.
//

import Foundation
import UIKit

struct SettingsOption {
    let title:String
    let icon:UIImage?
    let iconBackgroundColor: UIColor
    var isASwitch: Bool = false
    var isOn: Bool = false
    let handler: (()->Void)
}

struct Section{
    let title:String
    let options: [SettingsOption]
}
