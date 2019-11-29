//
//  SignUp.swift
//  Brief
//
//  Created by Ghassen Msaad on 11/29/19.
//  Copyright © 2019 Ghassen Msaad. All rights reserved.
//

import UIKit

class SignUp: UIViewController {

    @IBOutlet var imageUser: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var degre: UITextField!
    @IBOutlet weak var AdBureau: UITextField!
    @IBOutlet weak var AdDomicile: UITextField!
    @IBOutlet weak var tel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
        
        
        let nameImage = UIImage(named:"name")
        addRightImageTo(txtField: name, img: nameImage!)
        let mailImage = UIImage(named:"mail")
        addRightImageTo(txtField: mail, img: mailImage!)
        let degreImage = UIImage(named:"degre")
        addRightImageTo(txtField: degre, img: degreImage!)
        let AdBureauImage = UIImage(named:"ABureau")
        addRightImageTo(txtField: AdBureau, img: AdBureauImage!)
        let AdDomicileImage = UIImage(named:"ADomicile")
        addRightImageTo(txtField: AdDomicile, img: AdDomicileImage!)
        let telImage = UIImage(named:"num")
        addRightImageTo(txtField: tel, img: telImage!)

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
    }
    
    
    func addRightImageTo(txtField: UITextField, img: UIImage) {
        txtField.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 5, y: 0, width: txtField.frame.width, height: txtField.frame.height)
        imageView.image = img
        imageView.contentMode = .scaleAspectFit
        txtField.rightView = imageView
        
    }
    


}
