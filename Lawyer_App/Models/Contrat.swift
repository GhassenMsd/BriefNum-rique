//
//  Contrat.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Contrat: NSObject {

    var id = 0
    var sujet = ""
    var date: Date?
    var somme = 0.0
    var dateEnregistrement: Date?
    var numEnregistrement = 0
    var etat = ""
    var causeRetard = ""
    var id_Av = 0
    
    init(id: Int, sujet: String, date: Date, somme: Double, dateEnregistrement: Date, numEnregistrement: Int, etat: String, causeRetard: String, id_Av: Int){
        self.id = id
        self.sujet = sujet
        self.date = date
        self.somme = Double(somme)
        self.dateEnregistrement = dateEnregistrement
        self.numEnregistrement = numEnregistrement
        self.etat = etat
        self.causeRetard = causeRetard
        self.id_Av = id_Av
    }
}
