//
//  HuissierDeJustice.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class HuissierDeJustice: NSObject {

    var id = 0
    var nomComplet = ""
    var adresseBureau = ""
    var tel = ""
    var mail = ""
    var img = ""
    
    init(id: Int, nomComplet: String, adresseBureau: String, tel: String, mail: String, img: String){
        self.id = id
        self.nomComplet = nomComplet
        self.adresseBureau = adresseBureau
        self.tel = tel
        self.mail = mail
        self.img = img
    }
}
