//
//  Affaire.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 11/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Affaire: NSObject {
    
    var numAff = 0
    var degre = 0
    var sujet = ""
    var date = ""
    var etat = ""
    var numeroAffaire = 0
    var idClt = 0
    var idCrl = 0
    var idAdversaire = 0
    var cercle = ""
    var tribunal = ""
    //var id_Av = 0
    
    override init() {
        
    }
    
    init(numAff: Int,degre: Int, sujet: String,date: String, etat: String,numeroAffaire: Int, idClt: Int, idCrl: Int,cercle: String,tribunal: String,idAdversaire: Int){
        self.numAff = numAff
        self.degre = degre
        self.sujet = sujet
        self.date = date
        self.etat = etat
        self.numeroAffaire = numeroAffaire
        self.idClt = idClt
        self.idCrl = idCrl
        self.cercle = cercle
        self.tribunal = tribunal
        self.idAdversaire = idAdversaire
    }
}
