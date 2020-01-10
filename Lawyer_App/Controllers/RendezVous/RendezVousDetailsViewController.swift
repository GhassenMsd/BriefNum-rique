//
//  RendezVousDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class RendezVousDetailsViewController: UIViewController,UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        Shadow()
        nomText.text = rendezVous.nom
        lieuText.text = rendezVous.adresse
        sujetText.text = rendezVous.sujet
        noteText.text = rendezVous.notes
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = NSLocale(localeIdentifier: "ar_TN") as Locale
        dateText.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)

        let dateObj = self.dateFormatter1.date(from: rendezVous.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateText.text = formatter.string(from: dateObj!)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nomView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lieuView: UIView!
    @IBOutlet weak var sujetView: UIView!
    @IBOutlet weak var noteView: UIView!
    
    @IBOutlet weak var nomText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var lieuText: UITextField!
    @IBOutlet weak var sujetText: UITextView!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var updateAction: UIButton!
    @IBOutlet weak var btnToggleUpdate: UIBarButtonItem!
    
    var datePicker = UIDatePicker()
    let redezVousService = RendezVousService()
    var rendezVous = RendezVous()
    
    func Shadow(){
        nomView.addShadowView()
        dateView.addShadowView()
        lieuView.addShadowView()
        sujetView.addShadowView()
        noteView.addShadowView()
        updateAction.addShadowView()
    }
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapDateGuesture(){
        view.endEditing(true)
    }

    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateText.text = formatter.string(from: datePicker.date)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == sujetText.text {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
        if textView.text == noteText.text {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView == sujetText && textView.text == "" {
            textView.text = "الموضوع"
            textView.textColor = UIColor.lightGray
        }
        if textView == noteText && textView.text == "" {
            textView.text = "الملاحظات"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func Verif() -> Bool{
        var verif = true
        if(self.nomText.text!.isEmpty){
            self.nomText.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.dateText.text!.isEmpty){
            self.dateText.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.lieuText.text!.isEmpty){
            self.lieuText.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            verif = false
        }
        if(self.sujetText.text!.isEmpty){
            verif = false
        }
        if(self.noteText.text!.isEmpty){
            verif = false
        }

        return verif
    }
    
    @IBAction func toUpdateBtn(_ sender: Any) {
        //performSegue(withIdentifier: "toUpdateClient", sender: ProfilClient.client)
        self.nomText.isEnabled = true
        self.dateText.isEnabled = true
        self.lieuText.isEnabled = true
        self.sujetText.isEditable = true
        self.sujetText.isSelectable = true
        self.noteText.isEditable = true
        self.noteText.isSelectable = true
        self.btnToggleUpdate.isEnabled = false
        self.updateAction.isHidden = false
    }
    
    @IBAction func UpdateBtnAction(_ sender: Any) {
        if(Verif()){
            self.rendezVous.nom = self.nomText.text!
            self.rendezVous.date = self.dateText.text!
            self.rendezVous.adresse = self.lieuText.text!
            self.rendezVous.sujet = self.sujetText.text!
            self.rendezVous.notes = self.noteText.text!
            self.redezVousService.updateRendezVous(rendezVous: self.rendezVous){ (response) in
                print(response);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchRendezVous"), object: nil)
                
                //self.navigationController?.popViewController(animated: true)
            }
            
            self.nomText.isEnabled = false
            self.dateText.isEnabled = false
            self.lieuText.isEnabled = false
            self.sujetText.isEditable = false
            self.sujetText.isSelectable = false
            self.noteText.isEditable = false
            self.noteText.isSelectable = false
            self.btnToggleUpdate.isEnabled = true
            self.updateAction.isHidden = true
            
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
