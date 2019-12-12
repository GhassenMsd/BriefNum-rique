//
//  dataAvocat.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class dataAvocat: NSObject {

    var num = ""
    var cin = ""
    var nom = ""
    var prenom = ""
    
    init(num: String, cin: String, nom: String, prenom: String){
        self.num = num
        self.cin = cin
        self.nom = nom
        self.prenom = prenom
    }
}
