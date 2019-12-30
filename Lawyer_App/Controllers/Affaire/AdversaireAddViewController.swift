//
//  AdversaireAddViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/28/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit





class AdversaireAddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var imageUser: UIImageView!
    @IBOutlet var addImageBtn: UIButton!
    @IBOutlet var viewCin: UIView!
    @IBOutlet var dateNaissance: UITextField!
    @IBOutlet var viewDateCin: UIView!
    @IBOutlet var lieuNaissance: UITextField!
    @IBOutlet var viewDate: UIView!
    @IBOutlet var cin_pass: UITextField!
    @IBOutlet var viewplace: UIView!
    @IBOutlet var dateEmission: UITextField!
    @IBOutlet var viewName: UIView!
    @IBOutlet var proffession: UITextField!
    @IBOutlet var viewAdress: UIView!
    @IBOutlet var viewMet: UIView!
    @IBOutlet var mail: UITextField!
    @IBOutlet var viewMail: UIView!
    @IBOutlet var adresse: UITextField!
    @IBOutlet var nomComplet: UITextField!
    
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    let adversaireService = AdversaireService()

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

        return verif
    }
        
    @IBAction func addClient(_ sender: Any) {
        if(Verif()){
            self.adversaireService.addAdversaire(nomComplet: self.nomComplet.text!, dateNaissance: dateNaissance.text!, lieuNaissance: lieuNaissance.text!, cin_pass: cin_pass.text!, dateEmission: dateEmission.text!, proffession: proffession.text!, adresse: adresse.text!, mail: mail.text!, image: imageName, tel:"2222222" ){ (response) in
                print(response);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchAdversaire"), object: nil)
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
        viewDateCin.addShadowView()
        viewDate.addShadowView()
        viewplace.addShadowView()
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
        
        self.adversaireService.uploadImage(image: imageData) { (image) in
            self.imageName = image
        }
        //let fileUrl = info[UIImagePickerControllerPHAsset] as! PHAsset
        //let assetResources = PHAssetResource.assetResources(for: fileUrl)
        //print(assetResources.first!.originalFilename)

        /*let headers: HTTPHeaders = [:]
        // 2
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName:"image.jpg" , mimeType: "image/jpeg")
        },
            to: Connexion.adresse + "/UploadImage/exercice",
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        self.imageName = response.result.value as! String
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
                
        })*/

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
