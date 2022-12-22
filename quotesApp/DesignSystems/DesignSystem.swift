//
//  DesignSystem.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 21.12.2022.
//

import UIKit

public enum DesignSystem {
    
    
    enum Colors {
        public static let greenColor = UIColor(named: "green")!
        
        public static let blackColor = UIColor(named: "black")!
        
        public static let grayColor = UIColor(named: "gray")!
        
        public static let lightGrayColor = UIColor(named: "lightGray")!
        
        public static let redColor = UIColor(named: "red")!
        
        public static let whiteColor = UIColor(named: "white")!
        
        public static let separatorColor = UIColor(named: "separator")!
    }
    
    enum Fonts {
        
        ///SF PRO Body / Regular / 17px
        public static let bold24: UIFont = .systemFont(ofSize: 24, weight: .bold)
        
        ///SF PRO Body / Regular / 17px
        public static let regular24: UIFont = .systemFont(ofSize: 24, weight: .regular)
        
        ///SF PRO Body / Regular / 17px
        public static let regular17: UIFont = .systemFont(ofSize: 17, weight: .regular)
        
        ///SF PRO Body / Regular / 15px
        public static let regular15: UIFont = .systemFont(ofSize: 15, weight: .regular)
        
    }
    
    enum Sizes {
        
        public static let tableEstimatedRowHeight: CGFloat = 88
        
        public static let defaultMargin: CGFloat = 16
        
        public static let defaultMarginMinus: CGFloat = -16
        
    }
}
