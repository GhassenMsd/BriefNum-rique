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
 
 
@IBOutlet weak var degree: DropDown!
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
    
var hiden = true
var hidenClient = true
var hidenAvocat = true
var hidenEtat = true
    
var list = ["درجة 1", "درجة 2","درجة 3"]
var listClient = ["الحريف 1 ","الحريف 2","الحريف 3"]
var listAvocat = ["محامي 1","محامي 2","محامي 3"]
var listEtat = ["الدائرة 1","الدائرة 2","الدائرة 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DropDownList degree
        degree.optionArray = list
        degree.didSelect{(selectedText , index ,id) in
            self.hiden = true
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
        client.optionArray = listClient
        client.didSelect{(selectedText , index ,id) in
            self.hidenClient = true
            }
        client.listWillAppear {
            self.hidenClient = false
        }
        client.listWillDisappear {
            self.hidenClient = true
        }
        
        //DropDownList client
        etat.optionArray = listEtat
        etat.didSelect{(selectedText , index ,id) in
            self.hidenEtat = true
            }
        etat.listWillAppear {
            self.hidenEtat = false
        }
        etat.listWillDisappear {
            self.hidenEtat = true
        }
        
        //DropDownList avocat
        avocat.optionArray = listAvocat
        avocat.didSelect{(selectedText , index ,id) in
            self.hidenAvocat = true
            }
        avocat.listWillAppear {
            self.hidenAvocat = false
        }
        avocat.listWillDisappear {
            self.hidenAvocat = true
        }
        
        sujet.delegate = self
        ViewDegree.addShadowView()
        ViewClient.addShadowView()
        ViewAvocat.addShadowView()
        ViewEtat.addShadowView()
        ViewSujet.addShadowView()
        ViewDocument.addShadowView()
        ViewAdd.addShadowView()
        // Do any additional setup after loading the view, typically from a nib.
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
    
}
