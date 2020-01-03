//
//  AffaireService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/16/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class AffaireService: NSObject {
    
    override init() {
    }
    
    func getAll (completion: @escaping (Array<Affaire>) -> Void) {
    
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/Affaire/getAll/" + preferences.string(forKey: "idUser")!,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                print(response.result.value as! Array<Dictionary<String,Any>>)
            var affaires:Array<Affaire> = []
            for affaireDict in response.result.value as! Array<Dictionary<String,Any>> {
                
                affaires.append(Affaire(numAff: affaireDict["num_Aff"] as! Int,degre: affaireDict["degre"] as! Int, sujet: affaireDict["sujet"] as! String, date: affaireDict["date"] as! String, etat: affaireDict["etat"] as! String, numeroAffaire: affaireDict["numeroAffaire"] as! Int, idClt: affaireDict["id_Clt"] as! Int, idCrl: affaireDict["id_Crl"] as! Int, cercle: affaireDict["cercle"] as! String, tribunal: affaireDict["tribunal"] as! String,idAdversaire: affaireDict["idAdversaire"] as! Int))
            }
            completion(affaires)
            }
        }
    }
    
    
    
    func addAffaire(degre: Int, sujet: String, date: String, numeroAffaire: String, id_Clt: Int, id_Crl: Int,idAdversaire: Int, completion: @escaping (Int) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "degre": degre,
            "sujet": sujet,
            "date": date,
            "numeroAffaire": numeroAffaire,
            "id_Clt":id_Clt,
            "id_Crl":id_Crl,
            "id_Av":preferences.string(forKey: "idUser")!,
            "idAdversaire":idAdversaire
        ]
        Alamofire.request(Connexion.adresse + "/api/Affaire/AddAffaire", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            let responseDict = response.result.value as! Dictionary<String,Any>
            let idAffaire = responseDict["insertId"] as! Int
                completion(idAffaire)
            }
        }
    }
    
    func DeleteAffaire(id: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        
        Alamofire.request(Connexion.adresse + "/api/Affaire/Delete/" + id, method:.put, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
 
}
