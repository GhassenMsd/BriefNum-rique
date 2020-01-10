//
//  SignUp.swift
//  Brief
//
//  Created by Ghassen Msaad on 11/29/19.
//  Copyright © 2019 Ghassen Msaad. All rights reserved.
//

import UIKit

class SignUp: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet var imageUser: UIImageView!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var nomView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var degreeView: UIView!
    @IBOutlet weak var adresseView: UIView!
    @IBOutlet weak var telView: UIView!
    
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    let loginService = LoginService()
    
    @IBOutlet weak var nomComplet: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var degree: UITextField!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var addAvocatView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        

    }
    
    func initView(){
        addImageBtn.layer.cornerRadius = addImageBtn.frame.size.width / 2
        addImageBtn.clipsToBounds = true
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
        nomView.addShadowView()
        emailView.addShadowView()
        passwordView.addShadowView()
        degreeView.addShadowView()
        adresseView.addShadowView()
        telView.addShadowView()
        addAvocatView.addShadowView()
        imagePicker.delegate = self
    }
    
    @IBAction func OpenImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Error: \(info)")
        }
        pickedImageProduct = selectedImage
        self.imageUser.image = pickedImageProduct
        self.imageUser.contentMode = .scaleAspectFill
        
        guard let imageData = UIImageJPEGRepresentation(self.imageUser.image! , 1) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        self.loginService.uploadImageUser(image: imageData) { (image) in
            self.imageName = image
            print(image)
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    func Verif() -> Bool{
        var verif = true
        if(self.nomComplet.text!.isEmpty){
            self.nomComplet.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.email.text!.isEmpty){
            self.email.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.password.text!.isEmpty){
            self.password.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.degree.text!.isEmpty){
            self.degree.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.adresse.text!.isEmpty){
            self.adresse.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.tel.text!.isEmpty){
            self.tel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }

        return verif
    }
    
    @IBAction func addAvocatAction(_ sender: Any) {
        if(Verif()){
            let avocat = Avocat(id: 0, nomComplet: self.nomComplet.text!, grade: self.degree.text!, adresseBureau: self.adresse.text!, tel: self.tel.text!, email: self.email.text!, img: self.imageName, password: self.password.text!)
            self.loginService.RegisterAvocat(avocat: avocat){ (user) in
                print(user.email);
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


}
