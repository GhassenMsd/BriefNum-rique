//
//  JihetEttisal.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 13/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class JihetEttisal: NSObject {
    
    var id = 0
    var nomComplet = ""
    var adresse = ""
    var tel = ""
    var tel2 = ""
    var tel3 = ""
    var specialite = ""
    var tribunal = ""
    var cercle = ""
    
    override init() {
        
    }
    
    init(id:Int,nomComplet:String,adresse:String,tel:String,specialite:String,tribunal:String,cercle:String,tel2: String,tel3:String){
        self.id = id
        self.nomComplet = nomComplet
        self.adresse = adresse
        self.tel = tel
        self.specialite = specialite
        self.tribunal = tribunal
        self.cercle = cercle
        self.tel2 = tel2
        self.tel3 = tel3
    }

}
