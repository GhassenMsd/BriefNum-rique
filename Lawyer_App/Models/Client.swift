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
    var name: String?
    var mail: String?
    var cin: Int = 0
    var img: String?
    
    
    init (name: String, mail: String,cin: Int,img: String)  {
        self.name = name
        self.mail = mail
        self.cin = cin
        self.img = img
       }
}
