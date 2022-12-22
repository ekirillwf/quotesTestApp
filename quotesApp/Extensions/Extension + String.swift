//
//  Extension + String.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 22.12.2022.
//

import Foundation

extension String {
    func replacingText(replacingText: String) -> String {
        var string = self
        string = string.replacingOccurrences(of: replacingText, with: "", options: [.caseInsensitive, .regularExpression])
        return string
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
