//
//  ProfilUserViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 23/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Photos

class ProfilUserViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageUpdateBtn.layer.cornerRadius = imageUpdateBtn.frame.width / 2
        let preferences = UserDefaults.standard
        let decoded  = preferences.data(forKey: "user")
        user = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        self.imageUser.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + user.img)!)
        self.nomComplet.text = user.nomComplet
        self.degree.text = user.grade
        self.nomCompletEdit.text = user.nomComplet
        self.emailEdit.text = user.email
        self.adresseEdit.text = user.adresseBureau
        self.telEdit.text = user.tel
        self.imageUser.addShadowImage(radius: self.imageUser.frame.width / 2)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var imageUpdateBtn: UIButton!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var nomComplet: UILabel!
    @IBOutlet weak var nomCompletEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var adresseEdit: UITextField!
    @IBOutlet weak var telEdit: UITextField!
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    var clientService = ClientService()
    var user = User()
    @IBOutlet weak var btnEditNomComplet: UIButton!
    @IBOutlet weak var btnEditTel: UIButton!
    @IBOutlet weak var btnEditEmail: UIButton!
    @IBOutlet weak var btnEditAdresse: UIButton!
    
    @IBAction func OpenImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        
        self.clientService.uploadImage(image: imageData) { (image) in
            self.imageName = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nomCompletEditAction(_ sender: Any) {
        
        if(self.btnEditNomComplet.title(for: .normal) == "تعديل"){
            self.nomCompletEdit.isUserInteractionEnabled = true
            self.btnEditNomComplet.setTitle("تسجيل", for: .normal)
        }
        else{
            self.nomCompletEdit.isUserInteractionEnabled = false
            self.btnEditNomComplet.setTitle("تعديل", for: .normal)
            self.nomComplet.text = self.nomCompletEdit.text!
        }
    }
    
    
    @IBAction func emailEditAction(_ sender: Any) {
        if(self.btnEditNomComplet.title(for: .normal) == "تعديل"){
            self.emailEdit.isUserInteractionEnabled = true
            self.btnEditEmail.setTitle("تسجيل", for: .normal)
        }
        else{
            self.emailEdit.isUserInteractionEnabled = false
            self.btnEditEmail.setTitle("تعديل", for: .normal)
        }
    }
    
    
    @IBAction func adresseEditAction(_ sender: Any) {
        if(self.btnEditAdresse.title(for: .normal) == "تعديل"){
            self.adresseEdit.isUserInteractionEnabled = true
            self.btnEditAdresse.setTitle("تسجيل", for: .normal)
        }
        else{
            self.adresseEdit.isUserInteractionEnabled = false
            self.btnEditAdresse.setTitle("تعديل", for: .normal)
        }
    }
    
    
    @IBAction func telEditAction(_ sender: Any) {
        if(self.btnEditTel.title(for: .normal) == "تعديل"){
            self.telEdit.isUserInteractionEnabled = true
            self.btnEditTel.setTitle("تسجيل", for: .normal)
        }
        else{
            self.telEdit.isUserInteractionEnabled = false
            self.btnEditTel.setTitle("تعديل", for: .normal)
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
