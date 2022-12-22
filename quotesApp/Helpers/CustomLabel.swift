//
//  CustomLabel.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 22.12.2022.
//

import UIKit

class CustomLabel: UILabel {
    var textWillChange:((_ oldText: String?)->())? = nil
    var textDidChange:((_ newText: String?)->())? = nil
    override var text: String? {
        willSet {
            if textWillChange != nil {
                textWillChange!(self.text)
            }
        }
        didSet {
            if textDidChange != nil {
                textDidChange!(self.text)
            }
        }
    }
}
