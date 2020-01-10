//
//  forgetPasswordViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 06/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit
import MessageUI

public extension String {
    func isNumber() -> Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil && self.rangeOfCharacter(from: CharacterSet.letters) == nil
    }
    static func random(length: Int = 4) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}


class forgetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTelView.addShadowView()
        SendBtn.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailTelView: UIView!
    @IBOutlet weak var emailTel: UITextField!
    @IBOutlet weak var SendBtn: UIButton!
    let loginService = LoginService()
    var idAvocat = 0
    
    @IBAction func SendAction(_ sender: Any) {
        if(Verif()){
            if((self.emailTel.text!).isNumber()){
                print("num s7i7")
                loginService.SendSms(tel: Int(self.emailTel.text!)!){(response) in
                    print(response)
                    let dict = response
                    if(dict["code"] as! String != "" ){
                        let code = dict["code"] as! String
                        let userDict = dict["res"] as! Dictionary<String,Any>
                        self.idAvocat = userDict["id"] as! Int
                        if(!code.isEmpty){
                            self.performSegue(withIdentifier: "toVerifyCode", sender: code)
                        }
                    }
                    
                }
            }
            else{
                print("string")
                loginService.SendEmail(email: self.emailTel.text!){(response) in
                    print(response)
                    let dict = response
                    let code = dict["code"] as! String
                    let userDict = dict["res"] as! Dictionary<String,Any>
                    self.idAvocat = userDict["id"] as! Int
                    if(!code.isEmpty){
                        self.performSegue(withIdentifier: "toVerifyCode", sender: code)
                    }
                }
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func Verif() -> Bool{
        var verif = true
        if(self.emailTel.text!.isEmpty){
            self.emailTel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        return verif
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVerifyCode"{
            let code = sender as! String
            if let verifyCode = segue.destination as? VerificationCodeViewController {
                verifyCode.originalCode = code
                verifyCode.idAvocat = self.idAvocat
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
