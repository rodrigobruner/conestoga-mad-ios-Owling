//
//  UITextView.swift
//  Owling
//
//  Created by user228347 on 7/1/24.
//

import Foundation
import UIKit

func adjustUITextViewHeight(arg : UITextView) {
    arg.translatesAutoresizingMaskIntoConstraints = true
    arg.sizeToFit()
    arg.isScrollEnabled = true
}
