//
//  Cercle.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Cercle: NSObject {
    
    var id = 0
    var degre = ""
    var num = 0
    var numBureau = 0
    var numSalle = 0
    var dateSession: Date?
    var nomPresident = ""
    var telPresident = ""
    var nomPremierMembre = ""
    var telMembreP = ""
    var nomDeuxiemeMembre = ""
    var telMembreD = ""
    var acteurMinisterePublic = ""
    var telActeur = ""
    var secretaire = ""
    var telSecretaire = ""
    var id_Trib = 0
    
    init(id: Int, degre: String, num: Int, numBureau: Int, numSalle: Int, dateSession: Date, nomPresident: String, telPresident: String, nomPremierMembre: String, telMembreP: String, nomDeuxiemeMembre: String, telMembreD: String, acteurMinisterePublic: String, telActeur: String, secretaire: String, telSecretaire: String, id_Trib: Int){
        self.id = id
        self.degre = degre
        self.num = num
        self.numBureau = numBureau
        self.dateSession = dateSession
        self.nomPresident = nomPresident
        self.telPresident = telPresident
        self.nomPremierMembre = nomPremierMembre
        self.telMembreP = telMembreP
        self.nomDeuxiemeMembre = nomDeuxiemeMembre
        self.telMembreD = telMembreD
        self.acteurMinisterePublic = acteurMinisterePublic
        self.telActeur = telActeur
        self.secretaire = secretaire
        self.telSecretaire = telSecretaire
        self.id_Trib = id_Trib
    }

}
