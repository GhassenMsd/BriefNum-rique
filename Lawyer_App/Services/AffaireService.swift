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
                var numCasPrec = ""
                if( type(of: affaireDict["num_Cas_Prec"] ) == String.self ){
                    numCasPrec = affaireDict["num_Cas_Prec"] as! String
                }
                affaires.append(Affaire(nameAff: affaireDict["nomAff"] as! String, numAff: affaireDict["num_Aff"] as! String, degre: affaireDict["degre"] as! String, sujet: affaireDict["sujet"] as! String, date: affaireDict["date"] as! String, etat: affaireDict["etat"] as! String, idClt: affaireDict["id_Clt"] as! Int, idCrl: affaireDict["id_Crl"] as! Int, numCasPrec: numCasPrec, numAvCont: affaireDict["num_Av_Cont"] as! String, etatAvCont: affaireDict["etat_Av_Cont"] as! Int,cercle: affaireDict["cercle"] as! String))
            }
            completion(affaires)
            }
        }
    }
 
}
