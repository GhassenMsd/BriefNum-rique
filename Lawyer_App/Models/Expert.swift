//
//  Expert.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Expert: NSObject {
    
    var id = 0
    var nomComplet = ""
    var specialite = ""
    var adresseBureau = ""
    var tel = ""
    var contexte = ""
    var tribunal = ""
    
    init(id: Int, nomComplet: String, specialite: String, adresseBureau: String, tel: String, contexte: String, tribunal: String){
        self.id = id
        self.nomComplet = nomComplet
        self.specialite = specialite
        self.adresseBureau = adresseBureau
        self.tel = tel
        self.contexte = contexte
        self.tribunal = tribunal
    }
}
