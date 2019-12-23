//
//  DemandeUpdateViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/20/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandeUpdateViewController: UIViewController,UITextViewDelegate {
    var demande = Demande()
    @IBOutlet var NomDemande: UIView!
    @IBOutlet var jiha: UIView!
    @IBOutlet var type: UIView!
    @IBOutlet var sujet: UIView!
    @IBOutlet var date: UIView!
    
    @IBOutlet var button: UIButton!
    
    
    
    var datePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NomDemande.addShadowView()
        jiha.addShadowView()
        type.addShadowView()
        sujet.addShadowView()
        date.addShadowView()
        button.addShadowView()
        
        //init inputs
        nomDT.text = demande.nomDemande
        jihaT.text = demande.partieConcernee
        typeT.text = demande.type
        sujetT.text = demande.sujet
        dateT.text = demande.date
        
        
        sujetT.delegate = self
        datePicker.datePickerMode = .dateAndTime
        dateT.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var nomDT: UITextField!
    @IBOutlet var jihaT: UITextField!
    @IBOutlet var typeT: UITextField!
    @IBOutlet var sujetT: UITextView!
    @IBOutlet var dateT: UITextField!
    
    @IBAction func UpdateDemande(_ sender: Any) {
        let demandeService = DemandeService()
        demandeService.UpdateDemande(id: String(demande.id), nomDemande: nomDT.text!, partieConcernée: jihaT.text!, type: typeT.text!, sujet: sujetT.text!, date: dateT.text!, notes: "notes") { () in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchdemandeDetail"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
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
        dateT.text = formatter.string(from: datePicker.date)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == demande.sujet {
              textView.text = ""
              textView.textColor = UIColor(rgb: 0x003A33)
          }
      }
          
      func textViewDidEndEditing(_ textView: UITextView) {
          if textView.text == "" {

            textView.text = demande.sujet
              textView.textColor = UIColor.lightGray
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
