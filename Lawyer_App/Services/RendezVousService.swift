//
//  RendezVousService.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class RendezVousService: NSObject {

    override init() {
    }
    
    func getAll (completion: @escaping (Array<RendezVous>) -> Void) {
        
        let preferences = UserDefaults.standard
            //  Couldn't save (I've never seen this happen in real world testing)
        if( preferences.object(forKey: "token") != nil){
           
            Alamofire.request(Connexion.adresse + "/api/rendezvous/getAll",encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                    response in
                print(response.result.value as Any)
                var rendezvousArray:Array<RendezVous> = []
                for rendezvousDict in response.result.value as! Array<Dictionary<String,Any>> {
                    rendezvousArray.append(RendezVous(id : rendezvousDict["id"] as! Int, date : String((rendezvousDict["date"] as! String).prefix(10)), adresse : rendezvousDict["adresse"] as! String , sujet : rendezvousDict["sujet"] as! String , notes : rendezvousDict["notes"] as! String, id_Av : rendezvousDict["id_Av"] as! Int ))
                }
                completion(rendezvousArray)
                    
                }
            }
        }

    
}
