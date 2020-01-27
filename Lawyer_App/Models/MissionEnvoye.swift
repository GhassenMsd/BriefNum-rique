//
//  MIssionEnvoye.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/12/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class MissionEnvoye: NSObject {
    var dateLimite = ""
    var dateMission = ""
    var nomMission = ""
    var partieConcernee = ""
    var adressePartieC = ""
    var type = ""
    var requis = ""
    var notes = ""
    var avocatMoukabel = ""
    var numeroAffaire = 0
    
    init(dateLimite: String, dateMission: String, nomMission: String, partieConcernee: String, adressePartieC: String, type: String, requis: String, notes: String, avocatMoukabel: String, numeroAffaire: Int){
        self.dateLimite = dateLimite
        self.dateMission = dateMission
        self.nomMission = nomMission
        self.partieConcernee = partieConcernee
        self.adressePartieC = adressePartieC
        self.type = type
        self.requis = requis
        self.notes = notes
        self.avocatMoukabel = avocatMoukabel
        self.numeroAffaire = numeroAffaire

    }
    
    override init() {
    }
}
