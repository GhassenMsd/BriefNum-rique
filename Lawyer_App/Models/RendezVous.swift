//
//  RendezVous.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class RendezVous: NSObject {
    var id = 0
    var date: Date?
    var heure = ""
    var adresse = ""
    var sujet = ""
    var notes = ""
    var id_Av = 0
    
    init(id: Int, date: Date, heure: String, adresse: String, sujet: String, notes: String, id_Av: Int){
        self.id = id
        self.date = date
        self.heure = heure
        self.adresse = adresse
        self.sujet = sujet
        self.notes = notes
        self.id_Av = id_Av
    }
}
