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
                demandes.append(Demande(id: demandeDict["id"] as! Int, nomDomande: demandeDict["nomDemande"] as! String, partieConcernee: demandeDict["partieConcernée"] as! String, type: demandeDict["type"] as! String, sujet: demandeDict["sujet"] as! String, date: String((demandeDict["date"] as! String).prefix(10)), notes: demandeDict["notes"] as! String, id_Aff: demandeDict["id_Aff"] as! Int))
            }
            completion(demandes)
                
            }
        }
    }
    
    
    func AddDemande(nomDemande: String, partieConcernée: String,type: String,sujet: String,date: String,notes: String,id_Aff: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        let parameters: Parameters = [
            "nomDemande": nomDemande,
            "partieConcernée": partieConcernée,
            "type": type,
            "sujet": sujet,
            "date": date,
            "notes": notes,
            "id_Aff": id_Aff
        ]
        
        Alamofire.request(Connexion.adresse + "/api/Demande/AddDemande", method:.post, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response)
            completion()
        }
    }
    
    func DeleteDemande(id: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        
        Alamofire.request(Connexion.adresse + "/api/Demande/Delete/" + id, method:.put, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func UpdateDemande(id: String,nomDemande: String, partieConcernée: String,type: String,sujet: String,date: String,notes: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        let parameters: Parameters = [
            "id": id,
            "nomDemande": nomDemande,
            "partieConcernée": partieConcernée,
            "type": type,
            "sujet": sujet,
            "date": date,
            "notes": notes
        ]
       
        Alamofire.request(Connexion.adresse + "/api/Demande/Update", method:.put, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func getDemandeById (id: String,completion: @escaping (Demande) -> Void) {
    
    let preferences = UserDefaults.standard
       
        Alamofire.request(Connexion.adresse + "/api/Demande/getDemandeById/" + id,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as! Array<Dictionary<String,Any>>)
            let responseDict = response.result.value as! Dictionary<String,Any>
            let demande = Demande(id: responseDict["id"] as! Int, nomDomande: responseDict["nomDemande"] as! String, partieConcernee: responseDict["partieConcernée"] as! String, type: responseDict["type"] as! String, sujet: responseDict["sujet"] as! String, date: responseDict["date"] as! String, notes: responseDict["notes"] as! String, id_Aff: responseDict["id_Aff"] as! Int)
            completion(demande)
                
            }
        
    }
}
