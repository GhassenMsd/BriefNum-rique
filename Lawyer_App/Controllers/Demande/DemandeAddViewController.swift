//
//  DemandeAddViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/15/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import iOSDropDown

class DemandeAddViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var Affaire: DropDown!
    @IBOutlet weak var AdresseView: UIView!
    @IBOutlet weak var JihaView: UIView!
    @IBOutlet weak var AffaireView: UIView!
    @IBOutlet weak var TypeDemandeView: UIView!
    @IBOutlet weak var SujetView: UIView!
    @IBOutlet weak var DateDemandeView: UIView!
    @IBOutlet weak var Sujet: UITextView!
    @IBOutlet weak var DateDemande: UITextField!
    var datePicker = UIDatePicker()

    @IBOutlet weak var AddButton: UIButton!
    
    var hiden = true
    var list = ["القضية 1", "القضية 1","القضية 3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        Sujet.delegate = self
        datePicker.datePickerMode = .date
        DateDemande.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        //DropDownList affaires
        Affaire.optionArray = list
        Affaire.didSelect{(selectedText , index ,id) in
            self.hiden = true
            }
        Affaire.listWillAppear {
            self.hiden = false
        }
        
        Affaire.listWillDisappear {
            self.hiden = true
        }
        
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
    
    @IBAction func dropListAffaires(_ sender: Any) {
        if(hiden){
            Affaire.showList()
        }
        else{
            Affaire.hideList()
        }
    }
    
    func ShadowViews() -> Void {
        AdresseView.addShadowView()
        JihaView.addShadowView()
        AffaireView.addShadowView()
        TypeDemandeView.addShadowView()
        SujetView.addShadowView()
        DateDemandeView.addShadowView()
        AddButton.addShadowView()
    }
    
    @IBAction func Back(_ sender: Any) {
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
