//
//  Tribunal.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Tribunal: NSObject {

    var id = 0
    var nom = ""
    var degre = ""
    var etat = ""
    var adresse = ""
    var tel = ""
    var nomPresident = ""
    var nomAgentRepublique = ""
    
    init(id: Int, nom: String, degre: String, etat: String, adresse: String, tel: String, nomPresident: String, nomAgentRepublique: String){
        self.id = id
        self.nom = nom
        self.degre = degre
        self.etat = etat
        self.adresse = adresse
        self.tel = tel
        self.nomPresident = nomPresident
        self.nomAgentRepublique = nomAgentRepublique
    }
}
