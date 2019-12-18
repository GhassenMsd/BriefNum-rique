//
//  MissionService.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class MissionService: NSObject {

    override init() {
    }
    
    func getAll (completion: @escaping (Array<Mission>) -> Void) {
        
        let preferences = UserDefaults.standard
        if( preferences.object(forKey: "token") != nil){
           
            Alamofire.request(Connexion.adresse + "/api/mission/getAll",encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                    response in
                    print(response.result.value as! Array<Dictionary<String,Any>>)
                var missions:Array<Mission> = []
                for missionDict in response.result.value as! Array<Dictionary<String,Any>> {
                    missions.append(Mission(id : missionDict["id"] as! Int, nomMission : missionDict["nomMission"] as! String,date : String((missionDict["date"] as! String).prefix(10)), duree : missionDict["duree"] as! String, partieConsernee : missionDict["partieConcernee"] as! String , adressePartieC : missionDict["adressePartieC"] as! String , type : missionDict["type"] as! String, requis : missionDict["requis"] as! String, notes : missionDict["notes"] as! String , id_Aff: missionDict["id_Aff"] as! String ))
                }
                completion(missions)
                    
                }
            }
        }

}
