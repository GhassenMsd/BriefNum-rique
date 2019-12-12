//
//  BureauEnquete.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class BureauEnquete: NSObject {
    
    var id = 0
    var num = 0
    var juge = ""
    var telJuge = ""
    var secretaire = ""
    var telSecretaire = ""
    var acteurMinisterePublic = ""
    var telActeur = ""
    var id_Trib = 0
    
    init(id: Int, num: Int, juge: String, telJuge: String, secretaire: String, telSecretaire: String, acteurMinisterePublic: String, telActeur: String, id_Trib: Int){
        self.id = id
        self.num = num
        self.juge = juge
        self.telJuge = telJuge
        self.secretaire = secretaire
        self.telSecretaire = telSecretaire
        self.acteurMinisterePublic = acteurMinisterePublic
        self.telActeur = telActeur
        self.id_Trib = id_Trib
    }
}
