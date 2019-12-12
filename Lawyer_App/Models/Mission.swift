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
    var date: Date?
    var duree = ""
    var partieConsernee = ""
    var adressePartieC = ""
    var type = ""
    var requis = ""
    var notes = ""
    var id_Aff = ""
    
    init(id: Int, nomMission: String, date: Date,duree: String, partieConsernee: String, adressePartieC: String, type: String, requis: String, notes: String, id_Aff: String){
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
