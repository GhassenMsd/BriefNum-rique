//
//  Demande.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Demande: NSObject {

    var id = 0
    var nomDemande = ""
    var partieConcernee = ""
    var type = ""
    var sujet = ""
    var date = ""
    var notes = ""
    var id_Aff = 0
    
    override init() {
        
    }
    
    init(id: Int, nomDomande: String, partieConcernee: String, type: String, sujet: String, date: String, notes: String, id_Aff: Int){
        self.id = id
        self.nomDemande = nomDomande
        self.partieConcernee = partieConcernee
        self.type = type
        self.sujet = sujet
        self.date = date
        self.notes = notes
        self.id_Aff = id_Aff
    }
}
