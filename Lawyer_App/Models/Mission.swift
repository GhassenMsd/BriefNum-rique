//
//  Mission.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Mission: NSObject {
    
    var id = 0
    var nomMission = ""
    var date = ""
    var duree = ""
    var partieConsernee = ""
    var adressePartieC = ""
    var type = ""
    var requis = ""
    var notes = ""
    var id_Aff = 0
    
    override init() {
        
    }
    init(id: Int, nomMission: String, date: String,duree: String, partieConsernee: String, adressePartieC: String, type: String, requis: String, notes: String, id_Aff: Int){
        self.id = id
        self.nomMission = nomMission
        self.date = date
        self.duree = duree
        self.partieConsernee = partieConsernee
        self.adressePartieC = adressePartieC
        self.type = type
        self.requis = requis
        self.notes = notes
        self.id_Aff = id_Aff
    }
}
