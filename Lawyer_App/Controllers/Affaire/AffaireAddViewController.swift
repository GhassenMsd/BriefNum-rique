//
//  AffaireAddViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 01/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import iOSDropDown

extension UIView {

    func addShadowView(width:CGFloat=0, height:CGFloat=3, Opacidade:Float=0.12, maskToBounds:Bool=false, radius:CGFloat=8){
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: width, height: height)
         self.layer.shadowRadius = radius
         self.layer.cornerRadius = radius
         self.layer.shadowOpacity = Opacidade
         self.layer.masksToBounds = maskToBounds
    }
    func addShadowImage(radius:CGFloat){
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 3)
         self.layer.shadowRadius = radius
         self.layer.cornerRadius = radius
         self.layer.shadowOpacity = 0.12
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class AffaireAddViewController: UIViewController, UITextViewDelegate {
 
 
@IBOutlet var numText: UITextField!
@IBOutlet var ViewNum: UIView!
@IBOutlet var DateView: UIView!
@IBOutlet var dateText: UITextField!

    
@IBOutlet var degree: DropDown!
@IBOutlet weak var sujet: UITextView!
@IBOutlet weak var client: DropDown!
@IBOutlet weak var etat: DropDown!
@IBOutlet weak var avocat: DropDown!
@IBOutlet weak var ViewDegree: UIView!
@IBOutlet weak var ViewSujet: UIView!
@IBOutlet weak var ViewClient: UIView!
@IBOutlet weak var ViewEtat: UIView!
@IBOutlet weak var ViewAvocat: UIView!
@IBOutlet weak var ViewDocument: UIView!
@IBOutlet weak var ViewAdd: UIButton!
    
    
var datePicker = UIDatePicker()

var hiden = true
var hidenClient = true
var hidenAvocat = true
var hidenEtat = true
    
    
var idTribunal = 0
var idCercle = 0
var idClient = 0
var idAdversaire = 0

    
var listEtat : Array<Cercle> = []

var list : Array<Tribunal> = []

var listClient : Array<Client> = []

var listAvocat : Array<Adversaire> = []

    
    @objc func fetchClient() -> Void {
        let clientService = ClientService()
        clientService.getAll(){ (clients) in
            if(clients.count == 0){
                
            }else{
                self.listClient = clients
                self.client.optionArray = self.listClient.map({ (client) -> String in
                    return client.nomComplet
                })
                self.client.reloadInputViews()
            }
        }
    }
    
    @objc func fetchTribunal() -> Void {
        let tribunalService = TribunalService()
        
        tribunalService.GetAllTribunal(){ (tribunals) in
            if(tribunals.count == 0){
                
            }else{
                self.list = tribunals
                self.degree.optionArray = self.list.map({ (degree) -> String in
                    return degree.nom
                })
                self.degree.reloadInputViews()
            }
        }
        
        
    }
    
    @objc func fetchCercle(id: String) -> Void {
        let cercleService = CercleService()
        cercleService.GetAllCercle(idTribunal: id){ (cercles) in
            if(cercles.count == 0){
                
            }else{
                self.listEtat = cercles
                self.etat.optionArray = self.listEtat.map({ (etat) -> String in
                    return etat.degre
                })
                self.etat.reloadInputViews()
            }
        }
        
    }
    
    @objc func fetchAdversaire() -> Void {
        self.avocat.text = ""
        let adversaireService = AdversaireService()
        adversaireService.GetAllAdversaire(){(adversaires) in
            if(adversaires.count == 0){
                
            }else{
                self.listAvocat = adversaires
                self.avocat.optionArray = self.listAvocat.map({ (avocat) -> String in

                    return avocat.nomComplet

                })
                self.avocat.optionArray.append("إضافة ضد")
                //self.avocat.optionArray.reverse()
                self.avocat.reloadInputViews()
            }
            
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchClient()
        
        
       
        //DropDownList degree
        fetchTribunal()
        
        
        degree.didSelect{(selectedText , index ,id) in
            self.hiden = true
            self.idTribunal = self.list[index].id
            print("idTribunal " + String(self.idTribunal))
            
            self.fetchCercle(id: String(self.list[index].id))
        }
        
        degree.listWillAppear {
            self.hiden = false
        }
        degree.listWillDisappear {
            self.hiden = true
        }
        
        // Its Id Values and its optional
        //dropDown.optionIds = [1,23,54,22]
        // Image Array its optional
        //dropDown.ImageArray = [👩🏻‍🦳,🙊,🥞]
        
        //DropDownList client
        
    
        client.didSelect{(selectedText , index ,id) in
            self.hidenClient = true
            self.idClient = self.listClient[index].id
            print("idClient " + String(self.idClient))

            
            }
        client.listWillAppear {
            self.hidenClient = false
        }
        client.listWillDisappear {
            self.hidenClient = true
        }
        
        //DropDownList client
        etat.didSelect{(selectedText , index ,id) in
            self.idCercle = self.listEtat[index].id
            print("idCercle " + String(self.idCercle))

            self.hidenEtat = true
            }
        etat.listWillAppear {
            self.hidenEtat = false
        }
        etat.listWillDisappear {
            self.hidenEtat = true
        }
        
        //DropDownList avocat
        fetchAdversaire()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchAdversaire), name: NSNotification.Name(rawValue: "fetchAdversaire"), object: nil)
        
        avocat.didSelect{(selectedText , index ,id) in
            self.hidenAvocat = true

            if(selectedText == "إضافة ضد"){
                self.performSegue(withIdentifier: "addAdversaire", sender: self)
                print("idhaafeett dhed")
            }else{
                self.idAdversaire = self.listAvocat[index].id
                print("lisstt indexx from dhed " + String(self.listAvocat[index].id))
            }
            }
        avocat.listWillAppear {
            self.hidenAvocat = false
        }
        avocat.listWillDisappear {
            self.hidenAvocat = true
        }
        
        datePicker.datePickerMode = .dateAndTime
        dateText.inputView = datePicker
       
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
               
               
        
        sujet.delegate = self
        ViewNum.addShadowView()
        DateView.addShadowView()
        ViewDegree.addShadowView()
        ViewClient.addShadowView()
        ViewAvocat.addShadowView()
        ViewEtat.addShadowView()
        ViewSujet.addShadowView()
        ViewDocument.addShadowView()
        ViewAdd.addShadowView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func tapDateGuesture(){
        view.endEditing(true)
    }

    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        dateText.text = formatter.string(from: datePicker.date)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    @IBAction func ToggleDegre(_ sender: Any) {
        if(hiden){
            degree.showList()
        }
        else{
            degree.hideList()
        }
    }

    @IBAction func ToggleClient(_ sender: Any) {
        if(hidenClient){
            client.showList()
        }
        else{
            client.hideList()
        }
    }
        
    @IBAction func ToggleEtat(_ sender: Any) {
        if(hidenEtat){
            etat.showList()
        }
        else{
            etat.hideList()
        }
    }
        
    @IBAction func ToggleAvocat(_ sender: Any) {
        if(hidenAvocat){
            avocat.showList()
        }
        else{
            avocat.hideList()
        }
    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "الموضوع" {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {

            textView.text = "الموضوع"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "addAdversaire"{
        if segue.destination is AdversaireAddViewController {
            //sessionViewController.session = sessionS
        }
    }
    
}
    
    @IBAction func AddAffaire(_ sender: Any) {
        let affaireService = AffaireService()
        let sessionServices = SessionService()
        affaireService.addAffaire(degre: self.idTribunal, sujet: sujet.text!, date: dateText.text!, numeroAffaire: numText.text!, id_Clt: self.idClient, id_Crl: self.idCercle,idAdversaire: self.idAdversaire) { (id) in
            sessionServices.AddSession(nomSession: "", date: self.dateText.text!, sujet: "", notes: "", Disp_prep: "", Cpt_Rd_Sess: "", id_Aff: id){ () in
                
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchAffaire"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }

}
