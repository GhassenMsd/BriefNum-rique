//
//  DemandeAddViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/15/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandeAddViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var NomDemande: UIView!
    @IBOutlet weak var JihaView: UIView!
    @IBOutlet weak var TypeDemandeView: UIView!
    @IBOutlet weak var SujetView: UIView!
    @IBOutlet weak var DateDemandeView: UIView!
    
    var idAffaire = ""
    var idAffaireFromHome = ""

    
    var datePicker = UIDatePicker()

    @IBOutlet weak var AddButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        Sujet.delegate = self
        datePicker.datePickerMode = .dateAndTime
        DateDemande.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        
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
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        DateDemande.text = formatter.string(from: datePicker.date)
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

    func ShadowViews() -> Void {
        JihaView.addShadowView()
        TypeDemandeView.addShadowView()
        SujetView.addShadowView()
        DateDemandeView.addShadowView()
        AddButton.addShadowView()
        NomDemande.addShadowView()
    }
    
    @IBAction func Back(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var Sujet: UITextView!
    @IBOutlet var PartieCD: UITextField!

    @IBOutlet var NomD: UITextField!
    @IBOutlet weak var DateDemande: UITextField!
    @IBOutlet var typeDemande: UITextField!
    
    @IBAction func AddDemande(_ sender: Any) {
        let demandesService = DemandeService()
        
        if (self.idAffaire == ""){
            demandesService.AddDemande(nomDemande: NomD.text!, partieConcernée: PartieCD.text!, type: typeDemande.text!, sujet: Sujet.text!, date: DateDemande.text!,notes: "notes", id_Aff: idAffaireFromHome){ () in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchDemande"), object: nil)
            }
        }else if (self.idAffaireFromHome == ""){
            demandesService.AddDemande(nomDemande: NomD.text!, partieConcernée: PartieCD.text!, type: typeDemande.text!, sujet: Sujet.text!, date: DateDemande.text!,notes: "notes", id_Aff: idAffaire){ () in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMatleb"), object: nil)
                
            }
        }
        
        
        
        self.navigationController?.popViewController(animated: true)
        
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
