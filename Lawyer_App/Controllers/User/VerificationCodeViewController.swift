//
//  VerificationCodeViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 07/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController {

    var originalCode = ""
    var idAvocat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        code.addShadowView()
        verifyBtnView.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var verifyBtnView: UIButton!
    @IBOutlet weak var code: UIView!
    @IBOutlet weak var codeText: UITextField!
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func Verif() -> Bool{
        var verif = true
        if(self.codeText.text!.isEmpty){
            self.codeText.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        return verif
    }

    @IBAction func verifyCodeAction(_ sender: Any) {
        if(originalCode == self.codeText.text!){
            print(self.idAvocat)
            performSegue(withIdentifier: "toNewPassword", sender: self.idAvocat)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewPassword"{
            let idAvocat = sender as! Int
            if let newPassword = segue.destination as? newPasswordViewController {
                newPassword.idAvocat = idAvocat
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
