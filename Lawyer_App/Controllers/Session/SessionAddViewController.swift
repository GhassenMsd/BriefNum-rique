//
//  SessionAddViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionAddViewController: UIViewController, UITextViewDelegate {

    var idAffaire = ""
    var idAffaireFromHome = ""

    @IBOutlet weak var ViewDate: UIView!
    @IBOutlet weak var ViewSujet: UIView!
    @IBOutlet weak var ViewRemarque: UIView!
    @IBOutlet weak var ViewAutre: UIView!
    @IBOutlet weak var ViewAdd: UIButton!
    
    @IBOutlet var TVSujet: UITextView!
    @IBOutlet var TVDate: UITextField!
    @IBOutlet var TVRemarque: UITextView!
    @IBOutlet var TVAutre: UITextView!
    
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewAdd.addShadowView()
        ViewSujet.addShadowView()
        ViewDate.addShadowView()
        ViewAutre.addShadowView()
        ViewRemarque.addShadowView()
        
        print("idAffaire from Add :" + idAffaire)
        TVAutre.delegate = self
        TVSujet.delegate = self
        TVRemarque.delegate = self
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = NSLocale(localeIdentifier: "ar_TN") as Locale
        TVDate.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddSession(_ sender: Any) {
        let sessionService = SessionService()
        
        if (self.idAffaire == ""){
            sessionService.AddSession(nomSession: "Session", date: TVDate.text!, sujet: TVSujet.text, notes: TVRemarque.text, Disp_prep: TVAutre.text, Cpt_Rd_Sess: "aaa", id_Aff: Int(idAffaireFromHome)!){ () in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchSession"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchSessionByDate"), object: nil)
                
            }
        }else if (self.idAffaireFromHome == ""){
            sessionService.AddSession(nomSession: "Session", date: TVDate.text!, sujet: TVSujet.text, notes: TVRemarque.text, Disp_prep: TVAutre.text, Cpt_Rd_Sess: "aaa", id_Aff: Int(idAffaire)!){ () in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
                
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
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
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        TVDate.text = formatter.string(from: datePicker.date)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "الموضوع" {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
        if textView.text == "ملاحظات" {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
        if textView.text == "أحكام تحضيرية" {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView == TVSujet && textView.text == "" {

            textView.text = "الموضوع"
            textView.textColor = UIColor.lightGray
        }
        if textView == TVRemarque && textView.text == "" {

            textView.text = "ملاحظات"
            textView.textColor = UIColor.lightGray
        }
        if textView == TVAutre && textView.text == "" {

            textView.text = "أحكام تحضيرية"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnSession"{
            if let sessionsListViewController = segue.destination as? SessionsListViewController {
                sessionsListViewController.idAffaire = self.idAffaire
            }
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
