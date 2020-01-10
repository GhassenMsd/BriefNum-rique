//
//  newPasswordViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 07/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class newPasswordViewController: UIViewController {

    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var rePasswordView: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var sendBtnView: UIButton!
    var idAvocat = 0
    let loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.addShadowView()
        rePasswordView.addShadowView()
        sendBtnView.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func Verif() -> Bool{
        var verif = true
        if(self.password.text!.isEmpty){
            self.password.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.rePassword.text!.isEmpty){
            self.rePassword.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        return verif
    }
    
    @IBAction func sendBtnAction(_ sender: Any) {
        if(Verif()){
            if(self.password.text! == self.rePassword.text!){
                self.loginService.updatePasswordAvocat(id: self.idAvocat, password: self.password.text!){(response) in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
