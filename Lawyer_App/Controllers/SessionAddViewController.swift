//
//  SessionAddViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionAddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var ViewDate: UIView!
    @IBOutlet weak var ViewSujet: UIView!
    @IBOutlet weak var ViewRemarque: UIView!
    @IBOutlet weak var ViewAutre: UIView!
    @IBOutlet weak var ViewAdd: UIButton!
    
    @IBOutlet weak var TVSujet: UITextView!
    @IBOutlet weak var TVRemarque: UITextView!
    @IBOutlet weak var TVAutre: UITextView!
    @IBOutlet weak var TVDate: UITextField!
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewAdd.addShadowView()
        ViewSujet.addShadowView()
        ViewDate.addShadowView()
        ViewAutre.addShadowView()
        ViewRemarque.addShadowView()
        
        TVAutre.delegate = self
        TVSujet.delegate = self
        TVRemarque.delegate = self
        datePicker.datePickerMode = .date
        TVDate.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self , action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace,doneButton], animated: true)
        //TVDate.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapDateGuesture(){
        view.endEditing(true)
    }
    
    @objc func doneAction(){
        //getDateFromPicker()
        view.endEditing(true)
    }
    
    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
