//
//  TribunalService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/27/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TribunalService: NSObject {

    
    func GetAllTribunal (completion: @escaping (Array<Tribunal>) -> Void) {
        
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/Tribunal/getAll/" ,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            var tribunals:Array<Tribunal> = []
            for tribunalDict in response.result.value as! Array<Dictionary<String,Any>> {
                tribunals.append(Tribunal(id: tribunalDict["id"] as! Int, nom: tribunalDict["nom"] as! String, degre: tribunalDict["degre"] as! String, etat: tribunalDict["etat"] as! String, nomPresident: tribunalDict["nomPresident"] as! String, nomWakilAwel: tribunalDict["nomWakilAwel"] as! String, telWakilAwel: tribunalDict["telWakilAwel"] as! String, numBWakilAwel: tribunalDict["numBWakilAwel"] as! Int, nomWakilTheni: tribunalDict["nomWakilTheni"] as! String, telWakilTheni: tribunalDict["telWakilTheni"] as! String, numBWakilTheni: tribunalDict["numBWakilTheni"] as! Int, katebOthoun: tribunalDict["katebOthoun"] as! String, telKatebOthoun: tribunalDict["telKatebOthoun"] as! String))
                
            }
            completion(tribunals)
            
        }
        
        }
    }
}
