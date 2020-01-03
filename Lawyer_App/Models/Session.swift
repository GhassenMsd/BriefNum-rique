//
//  Session.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 12/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class Session: NSObject {
    var id = 0
    var nomSession = ""
    var date = ""
    var sujet = ""
    var notes = ""
    var Disp_prep = ""
    var Cpt_Rd_Sess = ""
    var id_Aff = 0
    var tribunal = 0
    
    override init() {
        
    }
    
    init(id: Int, nomSession: String, date: String, sujet: String, notes: String, Disp_prep: String, Cpt_Rd_Sess: String, id_Aff: Int,tribunal: Int){
        self.id = id
        self.nomSession = nomSession
        self.date = date
        self.sujet = sujet
        self.notes = notes
        self.Disp_prep = Disp_prep
        self.Cpt_Rd_Sess = Cpt_Rd_Sess
        self.id_Aff = id_Aff
        self.tribunal = tribunal
    }
    
    init(id: Int, nomSession: String, date: String, sujet: String, notes: String, Disp_prep: String, Cpt_Rd_Sess: String, id_Aff: Int){
        self.id = id
        self.nomSession = nomSession
        self.date = date
        self.sujet = sujet
        self.notes = notes
        self.Disp_prep = Disp_prep
        self.Cpt_Rd_Sess = Cpt_Rd_Sess
        self.id_Aff = id_Aff
    }
}
