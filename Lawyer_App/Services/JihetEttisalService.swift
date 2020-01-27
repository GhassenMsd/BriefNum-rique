//
//  JihetEttisal.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 13/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit
import Alamofire

class JihetEttisalService: NSObject {

    override init() {
    }
    
    func getAll (table: String, type: String, specialite: String, completion: @escaping (Array<JihetEttisal>) -> Void) {
    let preferences = UserDefaults.standard
        print("---------------")
        print(table)
        print(type)
        print(specialite)
        
        let parameters: Parameters = [
            "table": table,
            "type": type,
            "specialite": specialite
        ]
        
        Alamofire.request(Connexion.adresse + "/api/jihetEttisal/getBySpecialite/",parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
            response in
                print(response.result.value as! Array<Dictionary<String,Any>>)
        var jihetEttisals:Array<JihetEttisal> = []
        for jihetDict in response.result.value as! Array<Dictionary<String,Any>> {
            var specialite = ""
            var cercle = ""
            var tribunal = ""
            var tel = ""
            var tel2 = ""
            var tel3 = ""
            if(jihetDict["tel"] as? String != nil){
                tel = jihetDict["tel"] as! String
            }
            if(jihetDict["tel2"] as? String != nil){
                tel2 = jihetDict["tel2"] as! String
            }
            if(jihetDict["tel3"] as? String != nil){
                tel3 = jihetDict["tel3"] as! String
            }
            if(jihetDict["specialite"] as? String != nil){
                specialite = jihetDict["specialite"] as! String
            }
            if(jihetDict["cercle"] as? String != nil){
                cercle = jihetDict["cercle"] as! String
            }
            if(jihetDict["tribunal"] as? String != nil){
                tribunal = jihetDict["tribunal"] as! String
            }
            jihetEttisals.append(JihetEttisal(id: jihetDict["id"] as! Int, nomComplet: jihetDict["nomComplet"] as! String, adresse: jihetDict["adresse"] as! String, tel: tel, specialite: specialite, tribunal: tribunal, cercle: cercle,tel2: tel2,tel3: tel3))
        }
        completion(jihetEttisals)
            
        }
    }
    
}
