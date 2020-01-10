//
//  MissionAddFromHomeViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 02/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit
import iOSDropDown

class MissionAddFromHomeViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet var nomMission: UIView!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var JihaView: UIView!
    @IBOutlet weak var AdresseJihaView: UIView!
    @IBOutlet weak var TypeView: UIView!
    @IBOutlet weak var AmelView: UIView!
    @IBOutlet weak var NoteView: UIView!
    
    @IBOutlet weak var AffaireView: UIView!
    @IBOutlet var AddMission: UIButton!
    
    var idAffaire = ""
    let affaireService = AffaireService()
    var affaireList:Array<Affaire> = []
    var datePicker = UIDatePicker()
    var hiden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        fetchAffaire()
        Notes.delegate = self
        Affaire.didSelect{(selectedText , index ,id) in
            self.hiden = true
            self.idAffaire = String(self.affaireList[index].numAff)
            
            print("lisstt indexx " + self.idAffaire )
        }
        Affaire.listWillAppear {
            self.hiden = false
        }
        Affaire.listWillDisappear {
            self.hiden = true
        }
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = NSLocale(localeIdentifier: "ar_TN") as Locale

        DateObjectif.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.backgroundColor = .gray
           //done button & cancel button
        let doneButton = UIBarButtonItem(title: "فعله", style: .plain, target: self, action:#selector(tapDateGuesture))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton,doneButton], animated: false)

        // add toolbar to textField
        DateObjectif.inputAccessoryView = toolbar
        
        /*let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)*/
        

        // Do any additional setup after loading the view.
    }
    
    func fetchAffaire() -> Void {
        
        affaireService.getAll(){ (affaires) in
            if(affaires.count == 0){
                
            }else{
                self.affaireList = affaires
                self.Affaire.optionArray = self.affaireList.map({ (affaire) -> String in
                    print(affaire.numAff)
                    return "قضية عدد " + String(affaire.numAff)
                })
            
            }
        }
        
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapDateGuesture(){
        view.endEditing(true)
    }

    @IBAction func toggleAffaire(_ sender: Any) {
        if(hiden){
            Affaire.showList()
        }
        else{
            Affaire.hideList()
        }
    }
    
    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        DateObjectif.text = formatter.string(from: datePicker.date)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
          if textView.text == "ملاحظات" {
              textView.text = ""
              textView.textColor = UIColor(rgb: 0x003A33)
          }
      }
          
      func textViewDidEndEditing(_ textView: UITextView) {

          if textView.text == "" {
              textView.text = "ملاحظات"
              textView.textColor = UIColor.lightGray
          }
      }
    
    @IBOutlet var PartieC: UITextField!
  
    @IBOutlet var Nom: UITextField!
    @IBOutlet var AdressePartieC: UITextField!
    @IBOutlet weak var DateObjectif: UITextField!
    @IBOutlet weak var Notes: UITextView!
    @IBOutlet var typeMission: UITextField!
    @IBOutlet var AAmel: UITextField!
    @IBOutlet weak var Affaire: DropDown!
    
    @IBAction func AddMission(_ sender: Any) {
        
        if(Verif() && self.idAffaire != ""){
            let missionService = MissionService()
            missionService.AddMission(nomMission: Nom.text!, date: DateObjectif.text!, duree: "2 heures", partieConcernee: PartieC.text!, adressePartieC: AdressePartieC.text!, type: typeMission.text!, requis: AAmel.text!, notes: Notes.text!, id_Aff: idAffaire) { () in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMission"), object: nil)
 
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func ShadowViews() -> Void {
        DateView.addShadowView()
        JihaView.addShadowView()
        AdresseJihaView.addShadowView()
        TypeView.addShadowView()
        AmelView.addShadowView()
        NoteView.addShadowView()
        AddMission.addShadowView()
        nomMission.addShadowView()
        AffaireView.addShadowView()
    }
    
    func Verif() -> Bool{
        var verif = true
        if(self.AAmel.text!.isEmpty){
            self.AAmel.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.AdressePartieC.text!.isEmpty){
            self.AdressePartieC.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.Nom.text!.isEmpty){
            self.Nom.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.DateObjectif.text!.isEmpty){
            self.DateObjectif.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.Affaire.text!.isEmpty){
            self.Affaire.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.PartieC.text!.isEmpty){
            self.PartieC.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.typeMission.text!.isEmpty){
            self.typeMission.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.Notes.text!.isEmpty){
            verif = false
        }

        return verif
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

