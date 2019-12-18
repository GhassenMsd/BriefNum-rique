//
//  DemandeService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/18/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class DemandeService: NSObject {

    override init() {
    }
    
    func getAllByAffaire (idAffaire: String,completion: @escaping (Array<Demande>) -> Void) {
    
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/demande/getAllByAffaire/" + idAffaire,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            var demandes:Array<Demande> = []
            for demandeDict in response.result.value as! Array<Dictionary<String,Any>> {
                demandes.append(Demande(id: demandeDict["id"] as! Int, nomDomande: demandeDict["nomDemande"] as! String, partieConcernee: demandeDict["partieConcernée"] as! String, type: demandeDict["type"] as! String, sujet: demandeDict["sujet"] as! String, date: String((demandeDict["date"] as! String).prefix(10)), notes: demandeDict["notes"] as! String, id_Aff: demandeDict["id_Aff"] as! String))
            }
            completion(demandes)
                
            }
        }
    }
}
