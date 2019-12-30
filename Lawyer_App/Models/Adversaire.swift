//
//  Adversaire.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/27/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Adversaire: NSObject {
    
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
      var num_Av = 0
      var image = ""
      var etat = ""
      
      override init() {
      }
      
      init(id: Int,nomComplet: String,cin_pass: String, dateEmission: String, tel: String, dateNaissance: String, lieuNaissance: String, adresse :String, proffession: String, mail: String, num_Av: Int, image: String,etat: String) {
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
          self.num_Av = num_Av
          self.image = image
          self.etat = etat
      }
}
