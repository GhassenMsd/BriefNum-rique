//
//  CercleService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/27/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class CercleService: NSObject {
    
    func GetAllCercle (idTribunal: String,completion: @escaping (Array<Cercle>) -> Void) {
        
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
          
        Alamofire.request(Connexion.adresse + "/api/Cercle/getAll/" + idTribunal,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
            print(response.result.value as Any)
            var cercles:Array<Cercle> = []
            for cercleDict in response.result.value as! Array<Dictionary<String,Any>> {
                cercles.append(Cercle(id: cercleDict["id"] as! Int, degre: cercleDict["degre"] as! String, num: cercleDict["num"] as! Int, numBureau: cercleDict["numBureau"] as! Int, numSalle: cercleDict["numSalle"] as! Int, dateSession: cercleDict["dateSessions"] as! String, nomPresident: cercleDict["nomPresident"] as! String, telPresident: cercleDict["telPresident"] as! String, nomMembre: cercleDict["nomMembre"] as! String, secretaire: cercleDict["secretaire"] as! String, telSecretaire: cercleDict["telSecretaire"] as! String, id_Trib: cercleDict["id_Trib"] as! Int))
            }
            completion(cercles)
        }
        
        }
    }
}
