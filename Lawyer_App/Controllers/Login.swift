//
//  ViewController.swift
//  Brief
//
//  Created by Ghassen Msaad on 11/27/19.
//  Copyright © 2019 Ghassen Msaad. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        /*if sender.isSelected {
           sender.isSelected = false
        } else {
            sender.isSelected  = true
        }*/
    }
    
    
    
    
}

