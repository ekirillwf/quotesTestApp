//
//  ViewController.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 20.12.2022.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initLabel()
    }

    
    private func initLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        label.text = "HELLO"
        label.textColor = .black
        label.textAlignment = .center
        
        view.addSubview(label)
    }
}

