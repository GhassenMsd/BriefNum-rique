//
//  User.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(nomComplet,forKey: "nomComplet")
        coder.encode(grade,forKey: "grade")
        coder.encode(adresseBureau,forKey: "adresseBureau")
        coder.encode(tel,forKey: "tel")
        coder.encode(img,forKey: "img")
        coder.encode(password,forKey: "password")
        coder.encode(token,forKey: "token")
        coder.encode(email,forKey: "email")
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let nomComplet = coder.decodeObject(forKey: "nomComplet") as! String
        let grade = coder.decodeObject(forKey: "grade") as! String
        let adresseBureau = coder.decodeObject(forKey: "adresseBureau") as! String
        let tel = coder.decodeObject(forKey: "tel") as! String
        let img = coder.decodeObject(forKey: "img") as! String
        let password = coder.decodeObject(forKey: "password") as! String
        let token = coder.decodeObject(forKey: "token") as! String
        let email = coder.decodeObject(forKey: "email") as! String
        self.init(id: id,nomComplet: nomComplet,grade: grade,adresseBureau: adresseBureau,tel:tel,img:img,password:password,token:token,email: email)
    }
    
    
    var id = 0
    var nomComplet = ""
    var email = ""
    var grade = ""
    var adresseBureau = ""
    var tel = ""
    var img = ""
    var password = ""
    var token = ""
    
    init(id: Int, nomComplet: String, grade: String, adresseBureau: String, tel: String, img: String, password: String, token: String, email: String){
        self.id = id
        self.nomComplet = nomComplet
        self.grade = grade
        self.adresseBureau = adresseBureau
        self.tel = tel
        self.img = img
        self.password = password
        self.token = token
        self.email = email
    }
    
    override init() {
    }

}
