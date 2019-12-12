//
//  Avocat.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Avocat: NSObject {
    var id = 0
    var nomComplet = ""
    var grade = ""
    var adresseBureau = ""
    var tel = ""
    var email = ""
    var img = ""
    var password = ""
    
    init(id: Int, nomComplet: String, grade: String, adresseBureau: String, tel: String, email: String, img: String, password: String){
        self.id = id
        self.nomComplet = nomComplet
        self.grade = grade
        self.adresseBureau = adresseBureau
        self.tel = tel
        self.email = email
        self.img = img
        self.password = password
    }
}
