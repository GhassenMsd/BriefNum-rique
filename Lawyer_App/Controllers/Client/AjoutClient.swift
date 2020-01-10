//
//  AjoutClient.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/10/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Photos

extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.8
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}

class AjoutClient: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewCin: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewAdress: UIView!
    @IBOutlet weak var viewMet: UIView!
    @IBOutlet weak var viewMail: UIView!
    @IBOutlet weak var viewTel: UIView!
    @IBOutlet weak var addImageBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    @IBOutlet weak var nomComplet: UITextField!
    @IBOutlet weak var dateNaissance: UITextField!
    @IBOutlet weak var lieuNaissance: UITextField!
    @IBOutlet weak var cin_pass: UITextField!
    @IBOutlet weak var dateEmission: UITextField!
    @IBOutlet weak var proffession: UITextField!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var tel: UITextField!
    let clientService = ClientService()
    var datePicker = UIDatePicker()
    var datePickerEmission = UIDatePicker()
    
    func Verif() -> Bool{
        var verif = true
        if(self.nomComplet.text!.isEmpty){
            self.nomComplet.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.cin_pass.text!.isEmpty){
            self.cin_pass.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.dateNaissance.text!.isEmpty){
            self.dateNaissance.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.lieuNaissance.text!.isEmpty){
            self.lieuNaissance.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.dateEmission.text!.isEmpty){
            self.dateEmission.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.proffession.text!.isEmpty){
            self.proffession.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.adresse.text!.isEmpty){
            self.adresse.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.mail.text!.isEmpty){
            self.mail.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.tel.text!.isEmpty){
            self.tel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }

        return verif
    }
        
    @IBAction func addClient(_ sender: Any) {
        if(Verif()){
            self.clientService.addClient(nomComplet: self.nomComplet.text!, dateNaissance: dateNaissance.text!, lieuNaissance: lieuNaissance.text!, cin_pass: cin_pass.text!, dateEmission: dateEmission.text!, proffession: proffession.text!, adresse: adresse.text!, mail: mail.text!, image: imageName, tel: tel.text! ){ (response) in
                print(response);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchClient"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func OpenImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCin.addShadowView()
        viewDate.addShadowView()
        viewTel.addShadowView()
        viewName.addShadowView()
        viewAdress.addShadowView()
        viewMet.addShadowView()
        viewMail.addShadowView()
        imagePicker.delegate = self
        imageUser.addShadowImage(radius: imageUser.frame.width / 2)
        addImageBtn.layer.cornerRadius = addImageBtn.frame.size.width / 2
        imageUser.clipsToBounds = true
        datePicker.datePickerMode = .date
        datePickerEmission.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "ar_TN") as Locale
        datePickerEmission.locale = NSLocale(localeIdentifier: "ar_TN") as Locale

        dateNaissance.inputView = datePicker
        
        dateEmission.inputView = datePickerEmission
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)

        datePickerEmission.addTarget(self, action: #selector(dateChangedEmission), for: .valueChanged)
        let tapDateEmission = UITapGestureRecognizer(target: self, action: #selector(tapDateGuestureEmission))
        self.view.addGestureRecognizer(tapDateEmission)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDateGuesture(){
        view.endEditing(true)
    }

    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateNaissance.text = formatter.string(from: datePicker.date)
    }
    
    @objc func tapDateGuestureEmission(){
        view.endEditing(true)
    }

    @objc func dateChangedEmission(){
        getDateFromPickerEmission()
    }
    
    func getDateFromPickerEmission(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateEmission.text = formatter.string(from: datePickerEmission.date)
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
