//
//  SessionService.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class SessionService: NSObject {

    override init() {
    }
    
    func getAll (completion: @escaping (Array<Session>) -> Void) {
        
        let preferences = UserDefaults.standard
            //  Couldn't save (I've never seen this happen in real world testing)
        if( preferences.object(forKey: "token") != nil){
            print("idddUserrr" + preferences.string(forKey: "idUser")!)
           
            Alamofire.request(Connexion.adresse + "/api/session/getAll/" + preferences.string(forKey: "idUser")!,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                    response in
                    //print(response.result.value as Any)
                var sessions:Array<Session> = []
                for sessionDict in response.result.value as! Array<Dictionary<String,Any>> {
                    sessions.append(Session(id : sessionDict["id"] as! Int, nomSession : sessionDict["nomSession"] as! String,date : String((sessionDict["date"] as! String).prefix(10)), sujet : sessionDict["sujet"] as! String, notes : sessionDict["notes"] as! String , Disp_prep : sessionDict["Disp_prep"] as! String , Cpt_Rd_Sess : sessionDict["Cpt_Rd_Sess"] as! String, id_Aff : sessionDict["id_Aff"] as! String ))
                }
                completion(sessions)
                    
                }
            }
        }
    
    
    func getAllByAffaire (idAffaire: String,completion: @escaping (Array<Session>) -> Void) {
    
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
        print("idddUserrr" + preferences.string(forKey: "idUser")!)
       
        Alamofire.request(Connexion.adresse + "/api/session/getAllByAffaire/" + preferences.string(forKey: "idUser")! + "/" + idAffaire,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            var sessions:Array<Session> = []
            for sessionDict in response.result.value as! Array<Dictionary<String,Any>> {
                sessions.append(Session(id : sessionDict["id"] as! Int, nomSession : sessionDict["nomSession"] as! String,date : String((sessionDict["date"] as! String).prefix(10)), sujet : sessionDict["sujet"] as! String, notes : sessionDict["notes"] as! String , Disp_prep : sessionDict["Disp_prep"] as! String , Cpt_Rd_Sess : sessionDict["Cpt_Rd_Sess"] as! String, id_Aff : sessionDict["id_Aff"] as! String ))
            }
            completion(sessions)
                
            }
        }
    }
    
    
    func AddSession(nomSession: String, date: String,sujet: String,notes: String,Disp_prep: String,Cpt_Rd_Sess: String,id_Aff: Int, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        let parameters: Parameters = [
            "nomSession": nomSession,
            "date": date,
            "sujet": sujet,
            "notes": notes,
            "Disp_prep": Disp_prep,
            "Cpt_Rd_Sess": Cpt_Rd_Sess,
            "id_Aff": id_Aff
        ]
       
        Alamofire.request(Connexion.adresse + "/api/Session/AddSession", method:.post, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func DeleteSession(id: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        
        Alamofire.request(Connexion.adresse + "/api/Session/Delete/" + id, method:.put, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func UpdateSession(id: String,nomSession: String, date: String,sujet: String,notes: String,Disp_prep: String,Cpt_Rd_Sess: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        let parameters: Parameters = [
            "id": id,
            "nomSession": nomSession,
            "date": date,
            "sujet": sujet,
            "notes": notes,
            "Disp_prep": Disp_prep,
            "Cpt_Rd_Sess": Cpt_Rd_Sess
        ]
       
        Alamofire.request(Connexion.adresse + "/api/Session/Update", method:.put, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func getSessionById (id: String,completion: @escaping (Session) -> Void) {
    
    let preferences = UserDefaults.standard
       
        Alamofire.request(Connexion.adresse + "/api/Session/getSessionById/" + id,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as! Array<Dictionary<String,Any>>)
            let responseDict = response.result.value as! Dictionary<String,Any>
            let session = Session(id: responseDict["id"] as! Int , nomSession: responseDict["nomSession"] as! String, date: responseDict["date"] as! String, sujet: responseDict["sujet"] as! String, notes: responseDict["notes"] as! String, Disp_prep: responseDict["Disp_prep"] as! String, Cpt_Rd_Sess: responseDict["Cpt_Rd_Sess"] as! String, id_Aff: responseDict["id_Aff"] as! String)
            
            completion(session)
                
            }
        
    }

        
}
