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
    var nomPresident = ""
    var nomWakilAwel = ""
    var telWakilAwel = ""
    var numBWakilAwel = 0
    var nomWakilTheni = ""
    var telWakilTheni = ""
    var numBWakilTheni = 0
    var katebOthoun = ""
    var telKatebOthoun = ""
    
    init(id: Int, nom: String, degre: String, etat: String, nomPresident: String, nomWakilAwel: String, telWakilAwel: String, numBWakilAwel: Int, nomWakilTheni: String, telWakilTheni: String, numBWakilTheni: Int, katebOthoun: String, telKatebOthoun: String){
        self.id = id
        self.nom = nom
        self.degre = degre
        self.etat = etat
        self.nomPresident = nomPresident
        self.nomWakilAwel = nomWakilAwel
        self.telWakilAwel = telWakilAwel
        self.numBWakilAwel = numBWakilAwel
        self.nomWakilTheni = nomWakilTheni
        self.telWakilTheni = telWakilTheni
        self.numBWakilTheni = numBWakilTheni
        self.katebOthoun = katebOthoun
        self.telKatebOthoun = telKatebOthoun
    }
}
