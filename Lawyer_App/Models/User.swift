//
//  User.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id = 0
    var nomComplet = ""
    var grade = ""
    var adresseBureau = ""
    var tel = ""
    var img = ""
    var password = ""
    var token = ""
    
    init(id: Int, nomComplet: String, grade: String, adresseBureau: String, tel: String, img: String, password: String, token: String){
        self.id = id
        self.nomComplet = nomComplet
        self.grade = grade
        self.adresseBureau = adresseBureau
        self.tel = tel
        self.img = img
        self.password = password
        self.token = token
    }

}
