//
//  ViewController.swift
//  Brief
//
//  Created by Ghassen Msaad on 11/27/19.
//  Copyright © 2019 Ghassen Msaad. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class Login: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var connexionBtnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connexionBtnAction.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        let email = userName.text!
        let password = self.password.text!
        if( email != "" && password != ""){
            
            let loginService = LoginService()
            loginService.login(email: email, password: password){ (user) in
                if ( user.token == "" ){
                    print("ma5demch " + user.token)
                }
                else{
                    print(user);
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }

        }
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

