//
//  SettingsTableViewCell.swift
//  Owling
//
//  Created by user228347 on 6/27/24.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconContainer: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var labelSetting: UILabel!
    
    
    
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemBlue
        return mySwitch
    }()
    
    func set(option: SettingsOption){
        labelSetting.text = option.title
        iconImageView.image = option.icon
        iconContainer.backgroundColor = option.iconBackgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
        
        let containerSize: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: containerSize, height: containerSize)
        
        iconImageView.tintColor = .white
        
        iconImageView.center = iconContainer.center
        
        let imageSize: CGFloat = containerSize/1.5
        iconImageView.frame = CGRect(x: (containerSize-imageSize)/2, y: (containerSize-imageSize)/2, width: imageSize, height: imageSize)
    
    
        labelSetting.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                                    y: 0,
                                    width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                                    height: contentView.frame.size.height)
    }
}
