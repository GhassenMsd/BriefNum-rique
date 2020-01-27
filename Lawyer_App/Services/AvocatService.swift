//
//  AvocatService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/3/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AvocatService: NSObject {

    
    func getAvocatByDate (date: String,idTribunal: Int,completion: @escaping (Array<AvocatByDate>) -> Void) {
    
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
        print("idddUserrr" + preferences.string(forKey: "idUser")!)
        
        Alamofire.request(Connexion.adresse + "/api/Avocat/getAllByDate/" + date + "/" + String(idTribunal) + "/" + preferences.string(forKey: "idUser")! ,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            var avocats:Array<AvocatByDate> = []
            
            for avocatDict in response.result.value as! Array<Dictionary<String,Any>> {
                avocats.append(AvocatByDate(name: avocatDict["nomComplet"] as! String, affaire: avocatDict["affaire"] as! Int))
            }
            
            completion(avocats)
                
            }
        }
    }
    
    
}
