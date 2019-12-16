//
//  ObjectifAddViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/15/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ObjectifAddViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var AdresseView: UIView!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var JihaView: UIView!
    @IBOutlet weak var AdresseJihaView: UIView!
    @IBOutlet weak var AffaireView: UIView!
    @IBOutlet weak var TypeView: UIView!
    @IBOutlet weak var AmelView: UIView!
    @IBOutlet weak var NoteView: UIView!
    
    @IBOutlet weak var DateObjectif: UITextField!
    @IBOutlet weak var Notes: UITextView!
    var datePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        Notes.delegate = self
        datePicker.datePickerMode = .date
        DateObjectif.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back(_ sender: Any) {
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
        formatter.dateFormat = "yyyy/MM/dd"
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
    
    
    func ShadowViews() -> Void {
        AdresseView.addShadowView()
        DateView.addShadowView()
        JihaView.addShadowView()
        AdresseJihaView.addShadowView()
        AffaireView.addShadowView()
        TypeView.addShadowView()
        AmelView.addShadowView()
        NoteView.addShadowView()

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
