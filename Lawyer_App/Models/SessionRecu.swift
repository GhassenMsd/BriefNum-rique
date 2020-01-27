//
//  SessionRecu.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/10/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class SessionRecu: NSObject {

    var dateLimite = ""
    var dateSession = ""
    var sujetSession = ""
    var Disp_prep = ""
    var avocatMoukabel = ""
    var client = ""
    var numeroAffaire = 0
    var tribunal = ""
    
    init(dateLimite: String, dateSession: String, sujetSession: String, Disp_prep: String, avocatMoukabel: String, client: String, numeroAffaire: Int, tribunal: String){
        self.dateLimite = dateLimite
        self.dateSession = dateSession
        self.sujetSession = sujetSession
        self.Disp_prep = Disp_prep
        self.avocatMoukabel = avocatMoukabel
        self.client = client
        self.numeroAffaire = numeroAffaire
        self.tribunal = tribunal
    }
    
    override init() {
    }
}
