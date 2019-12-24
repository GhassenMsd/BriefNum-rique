//
//  Client.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/10/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Client: NSObject {
    
    var id: Int = 0
    var nomComplet = ""
    var cin_pass = ""
    var dateEmission = ""
    var tel = ""
    var dateNaissance = ""
    var lieuNaissance = ""
    var adresse = ""
    var proffession = ""
    var mail = ""
    var id_Av = 0
    var image = ""
    
    override init() {
    }
    
    init(id: Int,nomComplet: String,cin_pass: String, dateEmission: String, tel: String, dateNaissance: String, lieuNaissance: String, adresse :String, proffession: String, mail: String, id_Av: Int, image: String) {
        self.id = id
        self.nomComplet = nomComplet
        self.cin_pass = cin_pass
        self.dateEmission = dateEmission
        self.tel = tel
        self.dateNaissance = dateNaissance
        self.lieuNaissance = lieuNaissance
        self.adresse = adresse
        self.proffession = proffession
        self.mail = mail
        self.id_Av = id_Av
        self.image = image
    }
}
