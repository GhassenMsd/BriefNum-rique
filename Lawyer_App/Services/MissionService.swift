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
           
            Alamofire.request(Connexion.adresse + "/api/mission/getAll/" + preferences.string(forKey: "idUser")!,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                    response in
                    print(response.result.value as! Array<Dictionary<String,Any>>)
                var missions:Array<Mission> = []
                for missionDict in response.result.value as! Array<Dictionary<String,Any>> {
                    missions.append(Mission(id : missionDict["id"] as! Int, nomMission : missionDict["nomMission"] as! String,date : (missionDict["date"] as! String), duree : missionDict["duree"] as! String, partieConsernee : missionDict["partieConcernee"] as! String , adressePartieC : missionDict["adressePartieC"] as! String , type : missionDict["type"] as! String, requis : missionDict["requis"] as! String, notes : missionDict["notes"] as! String , id_Aff: missionDict["id_Aff"] as! Int ))
                }
                completion(missions)
                    
                }
            }
        }
    
    func getAllByAffaire (idAffaire: String,completion: @escaping (Array<Mission>) -> Void) {
    
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/mission/getAllByAffaire/" + preferences.string(forKey: "idUser")! + "/" + idAffaire,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                print(response.result.value as! Array<Dictionary<String,Any>>)
            var missions:Array<Mission> = []
            for missionDict in response.result.value as! Array<Dictionary<String,Any>> {
                missions.append(Mission(id : missionDict["id"] as! Int, nomMission : missionDict["nomMission"] as! String,date : String((missionDict["date"] as! String).prefix(10)), duree : missionDict["duree"] as! String, partieConsernee : missionDict["partieConcernee"] as! String , adressePartieC : missionDict["adressePartieC"] as! String , type : missionDict["type"] as! String, requis : missionDict["requis"] as! String, notes : missionDict["notes"] as! String, id_Aff: missionDict["id_Aff"] as! Int))
            }
            completion(missions)
                
            }
        }
    }
    
    func AddMission(nomMission: String, date: String,duree: String,partieConcernee: String,adressePartieC: String,type: String,requis: String,notes: String,id_Aff: String, completion: @escaping () -> Void){
        let preferences = UserDefaults.standard

        let parameters: Parameters = [
            "nomMission": nomMission,
            "date": date,
            "duree": duree,
            "partieConcernee": partieConcernee,
            "adressePartieC": adressePartieC,
            "type": type,
            "requis": requis,
            "notes": notes,
            "id_Aff": id_Aff
        ]
       
        
        Alamofire.request(Connexion.adresse + "/api/Mission/AddMission", method:.post, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value as Any)
                
            completion()
            
        }
    }
    
    func DeleteMission(id: String, completion: @escaping () -> Void){
        
        let preferences = UserDefaults.standard
        
        Alamofire.request(Connexion.adresse + "/api/Mission/Delete/" + id, method:.put, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            completion()
        }
    }
    
    func UpdateMission(id: String,nomMission: String, date: String,duree: String,partieConcernee: String,adressePartieC: String,type: String,requis: String,notes: String, completion: @escaping () -> Void){
        let preferences = UserDefaults.standard

        let parameters: Parameters = [
            "id": id,
            "nomMission": nomMission,
            "date": date,
            "duree": duree,
            "partieConcernee": partieConcernee,
            "adressePartieC": adressePartieC,
            "type": type,
            "requis": requis,
            "notes": notes
        ]
        
        Alamofire.request(Connexion.adresse + "/api/Mission/Update", method:.put, parameters:parameters, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value as Any)
            completion()
        }
    }
    
    func getMissionById (id: String,completion: @escaping (Mission) -> Void) {
    
    let preferences = UserDefaults.standard
       
        Alamofire.request(Connexion.adresse + "/api/mission/getMissionById/" + id,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as! Array<Dictionary<String,Any>>)
            let responseDict = response.result.value as! Dictionary<String,Any>

            let mission = Mission(id: responseDict["id"] as! Int, nomMission: responseDict["nomMission"] as! String, date: responseDict["date"] as! String, duree: responseDict["duree"] as! String, partieConsernee: responseDict["partieConcernee"] as! String, adressePartieC: responseDict["adressePartieC"] as! String, type: responseDict["type"] as! String, requis: responseDict["requis"] as! String, notes: responseDict["notes"] as! String, id_Aff: responseDict["id_Aff"] as! Int)

            completion(mission)
                
            }
        
    }
    
func getMissionsEnvoye (completion: @escaping (Array<MissionEnvoye>) -> Void) {
    
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
        
        Alamofire.request(Connexion.adresse + "/api/MissionEnvoye/getMissionEnvoye/" + preferences.string(forKey: "idUser")! , encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            
            var missionsEnvoye:Array<MissionEnvoye> = []
            for missionDict in response.result.value as! Array<Dictionary<String,Any>> {
                missionsEnvoye.append(MissionEnvoye(dateLimite: missionDict["dateLimite"] as! String, dateMission: missionDict["dateMission"] as! String, nomMission: missionDict["nomMission"] as! String, partieConcernee: missionDict["partieConcernee"] as! String, adressePartieC: missionDict["adressePartieC"] as! String, type: missionDict["type"] as! String, requis: missionDict["requis"] as! String, notes: missionDict["notes"] as! String, avocatMoukabel: missionDict["avocatMoukabel"] as! String, numeroAffaire: missionDict["numeroAffaire"] as! Int))
            }
            completion(missionsEnvoye)
                
            }
        }
    }
    
    
    
func getMissionsRecu (completion: @escaping (Array<MissionRecu>) -> Void) {
    
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
        
        Alamofire.request(Connexion.adresse + "/api/MissionRecu/getMissionRecu/" + preferences.string(forKey: "idUser")! , encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            
            var missionsRecu:Array<MissionRecu> = []
            for missionDict in response.result.value as! Array<Dictionary<String,Any>> {
                missionsRecu.append(MissionRecu(dateLimite: missionDict["dateLimite"] as! String, dateMission: missionDict["dateMission"] as! String, nomMission: missionDict["nomMission"] as! String, partieConcernee: missionDict["partieConcernee"] as! String, adressePartieC: missionDict["adressePartieC"] as! String, type: missionDict["type"] as! String, requis: missionDict["requis"] as! String, notes: missionDict["notes"] as! String, avocatMoukabel: missionDict["avocatMoukabel"] as! String, numeroAffaire: missionDict["numeroAffaire"] as! Int))
            }
            completion(missionsRecu)
                
            }
        }
    }
    
    

}
