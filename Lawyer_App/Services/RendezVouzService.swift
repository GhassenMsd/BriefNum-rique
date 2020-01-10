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
           
            Alamofire.request(Connexion.adresse + "/api/rendezvous/getAll/" + preferences.string(forKey: "idUser")!,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                    response in
                print(response.result.value as Any)
                var rendezvousArray:Array<RendezVous> = []
                for rendezvousDict in response.result.value as! Array<Dictionary<String,Any>> {
                    rendezvousArray.append(RendezVous(id : rendezvousDict["id"] as! Int, nom:rendezvousDict["nom"] as! String , date : (rendezvousDict["date"] as! String), adresse : rendezvousDict["adresse"] as! String , sujet : rendezvousDict["sujet"] as! String , notes : rendezvousDict["notes"] as! String, id_Av : rendezvousDict["id_Av"] as! Int ))
                }
                completion(rendezvousArray)
                    
                }
            }
        }

    func addRendezVous(nom:String, date: String, adresse: String, sujet: String, notes: String, completion: @escaping (String) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "nom":nom,
            "date": date,
            "adresse": adresse,
            "sujet": sujet,
            "notes": notes,
            "id_Av":preferences.string(forKey: "idUser")!
        ]
        Alamofire.request(Connexion.adresse + "/api/RendezVous/AddRendezVous", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value as Any)
                let result = response.result.value as! String
                
                completion(result)
            }
        }
    }
    
    func updateRendezVous(rendezVous: RendezVous, completion: @escaping (String) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "id": rendezVous.id,
            "nom": rendezVous.nom,
            "date": rendezVous.date,
            "adresse": rendezVous.adresse,
            "sujet": rendezVous.sujet,
            "notes": rendezVous.notes
        ]
        Alamofire.request(Connexion.adresse + "/api/RendezVous/Update", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value)
                let result = response.result.value as! String
                
                completion(result)
            }
        }
    }
    
    func deleteRendezVous(id: Int, completion: @escaping (String) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "id": id
        ]
        Alamofire.request(Connexion.adresse + "/api/RendezVous/Delete", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value)
                let result = response.result.value as! String
                
                completion(result)
            }
        }
    }
}
