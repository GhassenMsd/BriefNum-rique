//
//  SessionUpdateViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/20/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionUpdateViewController: UIViewController, UITextViewDelegate {

    
    var session = Session()
    
    
    @IBOutlet var viewNom: UIView!
    @IBOutlet weak var ViewDate: UIView!
    @IBOutlet weak var ViewSujet: UIView!
    @IBOutlet weak var ViewRemarque: UIView!
    @IBOutlet weak var ViewAutre: UIView!
    @IBOutlet weak var ViewAdd: UIButton!
    
    @IBOutlet var TVNom: UITextField!
    @IBOutlet var TVSujet: UITextView!
    @IBOutlet var TVDate: UITextField!
    @IBOutlet var TVRemarque: UITextView!
    @IBOutlet var TVAutre: UITextView!
    
    var datePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        TVNom.text = session.nomSession
        TVSujet.text = session.sujet
        TVDate.text = session.date
        TVRemarque.text = session.notes
        TVAutre.text = session.Disp_prep
        
        ViewAdd.addShadowView()
        ViewSujet.addShadowView()
        ViewDate.addShadowView()
        ViewAutre.addShadowView()
        ViewRemarque.addShadowView()
        viewNom.addShadowView()
        
        TVAutre.delegate = self
        TVSujet.delegate = self
        TVRemarque.delegate = self
        datePicker.datePickerMode = .dateAndTime
        TVDate.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func UpdateSession(_ sender: Any) {
        let sessionService = SessionService()
        sessionService.UpdateSession(id: String(session.id), nomSession: TVNom.text!, date: TVDate.text!, sujet: TVSujet.text!, notes: TVRemarque.text!, Disp_prep: TVAutre.text!, Cpt_Rd_Sess: "0") { () in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchSessionDetail"), object: nil)
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
        TVDate.text = formatter.string(from: datePicker.date)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TVSujet.text {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
        if textView.text == TVRemarque.text {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
        if textView.text == TVAutre.text {
            textView.text = ""
            textView.textColor = UIColor(rgb: 0x003A33)
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView == TVSujet && textView.text == "" {
            textView.text = session.sujet
            textView.textColor = UIColor.lightGray
        }
        if textView == TVRemarque && textView.text == "" {
            textView.text = session.notes
            textView.textColor = UIColor.lightGray
        }
        if textView == TVAutre && textView.text == "" {
            textView.text = session.Disp_prep
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
