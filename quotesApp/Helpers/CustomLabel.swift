//
//  CustomLabel.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 22.12.2022.
//

import UIKit

class CustomLabel: UILabel {
    override var text: String? {
        didSet {
            if let text = text {
                if oldValue != text {
                    let oldVal = (oldValue?.trim() ?? "").replacingText(replacingText: "%")
                    let newVal = text.trim().replacingText(replacingText: "%")
                    
                    self.textColor = DesignSystem.Colors.whiteColor
                    if Double(oldVal) ?? 0 <= Double(newVal) ?? 0 {
                        self.backgroundColor = DesignSystem.Colors.greenColor
                    } else {
                        self.backgroundColor = DesignSystem.Colors.redColor
                    }
                } else {
                    self.backgroundColor = .clear
                }
            }
        }
    }
}
