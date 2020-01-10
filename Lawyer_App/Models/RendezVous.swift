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
    var nom = ""
    var date = ""
    var adresse = ""
    var sujet = ""
    var notes = ""
    var id_Av = 0
    
    override init() {
        
    }
    
    init(id: Int, nom:String, date: String, adresse: String, sujet: String, notes: String, id_Av: Int){
        self.id = id
        self.nom = nom
        self.date = date
        self.adresse = adresse
        self.sujet = sujet
        self.notes = notes
        self.id_Av = id_Av
    }
}
