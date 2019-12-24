//
//  UpdateClientViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 22/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Photos

class UpdateClientViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewCin: UIView!
    @IBOutlet weak var viewDateCin: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewplace: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewAdress: UIView!
    @IBOutlet weak var viewMet: UIView!
    @IBOutlet weak var viewMail: UIView!
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
    let clientService = ClientService()
    var datePicker = UIDatePicker()
    var datePickerEmission = UIDatePicker()
    var client = Client()
    
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
    
    @IBAction func UpdateActionBtn(_ sender: Any) {
        if(Verif()){
            self.clientService.updateClient(id: client.id,nomComplet: self.nomComplet.text!, dateNaissance: dateNaissance.text!, lieuNaissance: lieuNaissance.text!, cin_pass: cin_pass.text!, dateEmission: dateEmission.text!, proffession: proffession.text!, adresse: adresse.text!, mail: mail.text!, image: imageName){ (response) in
                print(response);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchClient"), object: nil)
                ProfilClient.client.nomComplet = self.nomComplet.text!
                ProfilClient.client.cin_pass = self.cin_pass.text!
                ProfilClient.client.dateNaissance = self.dateNaissance.text!
                ProfilClient.client.lieuNaissance = self.lieuNaissance.text!
                ProfilClient.client.cin_pass = self.cin_pass.text!
                ProfilClient.client.dateEmission = self.dateEmission.text!
                ProfilClient.client.proffession = self.proffession.text!
                ProfilClient.client.adresse = self.adresse.text!
                ProfilClient.client.mail = self.mail.text!
                ProfilClient.client.image = self.imageName
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)

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
        self.nomComplet.text! = client.nomComplet
        self.dateNaissance.text! = String(client.dateNaissance.prefix(10))
        self.lieuNaissance.text! = client.lieuNaissance
        self.cin_pass.text! = client.cin_pass
        self.dateEmission.text! = String(client.dateEmission.prefix(10))
        self.proffession.text! = client.proffession
        self.adresse.text! = client.adresse
        self.mail.text! = client.mail
        self.imageName = client.image
        self.imageUser.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + client.image)!)
        self.imageUser.contentMode = .scaleAspectFill

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
    


}
