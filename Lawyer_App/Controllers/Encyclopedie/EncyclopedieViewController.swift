//
//  EncyclopedieViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/16/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import iOSDropDown
class EncyclopedieViewController: UIViewController {
    @IBOutlet weak var EncyView: UIView!
    @IBOutlet weak var FaslView: UIView!
    @IBOutlet weak var EncyText: DropDown!
    @IBOutlet weak var FaslText: DropDown!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    var hidenEncy = true
    var hidenFasl = true
    
    var test1 = false
    var test2 = false


    var listEncy = ["المجلة التجارية", "المجلة التجارية","مجلة الأحوال الشخصية","مجلة الشركات التجارية","مجلة المرافعات المدنية والتجارية","المجلة الجزائية","مجلة الإجراءات الجزائية"]
    var listFasl = ["01","02","03","04"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        
        //DropDownList Encyclopedie
        EncyText.optionArray = listEncy
        EncyText.didSelect{(selectedText , index ,id) in
            self.hidenEncy = true
                
            }
        EncyText.listWillAppear {
            self.hidenEncy = false
        }
        
        EncyText.listWillDisappear {
            self.hidenEncy = true
            self.test1 = true
            if(self.test1 && self.test2){
                self.View1.isHidden = false
                self.View2.isHidden = false
            }
        }
        
        
        //DropDownList Fasl
        FaslText.optionArray = listFasl
        FaslText.didSelect{(selectedText , index ,id) in
            self.hidenFasl = true
            }
        FaslText.listWillAppear {
            self.hidenFasl = false
        }
        
        FaslText.listWillDisappear {
            self.hidenFasl = true
                self.test2 = true
                if(self.test1 && self.test2){
                    self.View1.isHidden = false
                    self.View2.isHidden = false
                }
            
        }
        
        
        
    }
    
    @IBAction func DropListEncy(_ sender: Any) {
        if(hidenEncy){
            EncyText.showList()
        }
        else{
            EncyText.hideList()
        }
    }
    
    @IBAction func DropListFasl(_ sender: Any) {
        if(hidenFasl){
            FaslText.showList()
        }
        else{
            FaslText.hideList()
        }
    }
    
    
    func ShadowViews() -> Void {
        EncyView.addShadowView()
        FaslView.addShadowView()
        View1.addShadowView()
        View2.addShadowView()
    }


}
