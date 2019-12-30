//
//  ProfilClient.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/9/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import SDWebImage

class ProfilClient: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    static var client:Client = Client()
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var adresseView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var telView: UIView!
    @IBOutlet weak var travailView: UIView!
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nomComplet: UITextField!
    @IBOutlet weak var dateNaiss: UITextField!
    @IBOutlet weak var lieuNaiss: UITextField!
    @IBOutlet weak var cin_pass: UITextField!
    @IBOutlet weak var dateEmiss: UITextField!
    @IBOutlet weak var profession: UITextField!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var nbrAffaire: UILabel!
    @IBOutlet weak var btnEnableUpdate: UIBarButtonItem!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    var datePicker = UIDatePicker()
    var datePickerEmission = UIDatePicker()
    let clientService = ClientService()

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
        if(self.dateNaiss.text!.isEmpty){
            self.dateNaiss.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.lieuNaiss.text!.isEmpty){
            self.lieuNaiss.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.dateEmiss.text!.isEmpty){
            self.dateEmiss.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.profession.text!.isEmpty){
            self.profession.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
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
        if(self.email.text!.isEmpty){
            self.email.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }

        return verif
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
        dateView.addShadowView()
        birthView.addShadowView()
        adresseView.addShadowView()
        mailView.addShadowView()
        nameView.addShadowView()
        telView.addShadowView()
        travailView.addShadowView()
        btnUpdate.addShadowView()
        imagePicker.delegate = self
        imageUser.addShadowImage(radius: imageUser.frame.width / 2)
        addImageBtn.layer.cornerRadius = addImageBtn.frame.size.width / 2
        self.imageName = ProfilClient.client.image
        datePicker.datePickerMode = .date
        datePickerEmission.datePickerMode = .date
        self.dateNaiss.inputView = datePicker
        
        self.dateEmiss.inputView = datePickerEmission
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)

        datePickerEmission.addTarget(self, action: #selector(dateChangedEmission), for: .valueChanged)
        let tapDateEmission = UITapGestureRecognizer(target: self, action: #selector(tapDateGuestureEmission))
        self.view.addGestureRecognizer(tapDateEmission)

        
        reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)


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
        self.dateNaiss.text = formatter.string(from: datePicker.date)
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
        dateEmiss.text = formatter.string(from: datePickerEmission.date)
    }

    
    @IBAction func toUpdateBtn(_ sender: Any) {
        //performSegue(withIdentifier: "toUpdateClient", sender: ProfilClient.client)
        self.nomComplet.isEnabled = true
        self.cin_pass.isEnabled = true
        self.dateEmiss.isEnabled = true
        self.dateNaiss.isEnabled = true
        self.lieuNaiss.isEnabled = true
        self.adresse.isEnabled = true
        self.profession.isEnabled = true
        self.tel.isEnabled = true
        self.email.isEnabled = true
        self.addImageBtn.isHidden = false
        self.btnEnableUpdate.isEnabled = false
        self.btnUpdate.isHidden = false
    }
    
    @IBAction func btnUpdateAction(_ sender: Any) {
        if(Verif()){
            self.clientService.updateClient(id: ProfilClient.client.id,nomComplet: self.nomComplet.text!, dateNaissance: dateNaiss.text!, lieuNaissance: lieuNaiss.text!, cin_pass: cin_pass.text!, dateEmission: dateEmiss.text!, proffession: profession.text!, adresse: adresse.text!, mail: email.text!, image: imageName, tel: tel.text!){ (response) in
                print(response);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchClient"), object: nil)
                self.nomComplet.isEnabled = false
                self.cin_pass.isEnabled = false
                self.dateEmiss.isEnabled = false
                self.dateNaiss.isEnabled = false
                self.lieuNaiss.isEnabled = false
                self.adresse.isEnabled = false
                self.profession.isEnabled = false
                self.tel.isEnabled = false
                self.email.isEnabled = false
                self.btnEnableUpdate.isEnabled = true
                self.btnUpdate.isHidden = true
                self.addImageBtn.isHidden = true
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if(segue.identifier == "toUpdateClient"){
            let client = sender as! Client
            if let updateClientViewController = segue.destination as? UpdateClientViewController {
                updateClientViewController.client = client
            }

        }*/
    }
    
    @objc func reloadData(){
        imageUser.sd_imageIndicator = SDWebImageActivityIndicator.gray

        imageUser.sd_setImage(with: URL(string: Connexion.adresse + "/Ressources/Client/" + ProfilClient.client.image)!, placeholderImage: UIImage(named: "placeholder"))
        imageUser.contentMode = .scaleAspectFill
        nomComplet.text = ProfilClient.client.nomComplet
        dateNaiss.text = String(ProfilClient.client.dateNaissance.prefix(10))
        lieuNaiss.text = ProfilClient.client.lieuNaissance
        cin_pass.text = ProfilClient.client.cin_pass
        dateEmiss.text = String(ProfilClient.client.dateEmission.prefix(10))
        profession.text = ProfilClient.client.proffession
        adresse.text = ProfilClient.client.adresse
        email.text = ProfilClient.client.mail
        tel.text = ProfilClient.client.tel
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
