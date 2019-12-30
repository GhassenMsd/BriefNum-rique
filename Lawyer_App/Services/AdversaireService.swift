//
//  AdversaireService.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/27/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AdversaireService: NSObject {
    
    func GetAllAdversaire (completion: @escaping (Array<Adversaire>) -> Void) {
        
    let preferences = UserDefaults.standard
        //  Couldn't save (I've never seen this happen in real world testing)
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/Adversaire/getAll/" ,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
                //print(response.result.value as Any)
            
            var adversaires:Array<Adversaire> = []
            for adversaireDict in response.result.value as! Array<Dictionary<String,Any>> {
                adversaires.append(Adversaire(id: adversaireDict["id"] as! Int, nomComplet: adversaireDict["nomComplet"] as! String, cin_pass: adversaireDict["cin_pass"] as! String, dateEmission: adversaireDict["dateEmission"] as! String, tel: adversaireDict["tel"] as! String, dateNaissance: adversaireDict["dateNaissance"] as! String, lieuNaissance: adversaireDict["lieuNaissance"] as! String, adresse: adversaireDict["adresse"] as! String, proffession: adversaireDict["proffession"] as! String, mail: adversaireDict["mail"] as! String, num_Av: adversaireDict["num_Av"] as! Int, image: adversaireDict["image"] as! String, etat: adversaireDict["etat"] as! String,AvocatAdversaire: adversaireDict["AvocatAdversaire"] as! String))
                }

                completion(adversaires)

            }
            
        }
        
        }
    
    
    func addAdversaire(nomComplet: String, dateNaissance: String, lieuNaissance: String, cin_pass: String, dateEmission: String, proffession: String, adresse: String, mail: String, image: String, tel: String,AvocatAdversaire: String, completion: @escaping (String) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "nomComplet": nomComplet,
            "dateNaissance": dateNaissance,
            "lieuNaissance": lieuNaissance,
            "cin_pass": cin_pass,
            "dateEmission":dateEmission,
            "proffession":proffession,
            "adresse":adresse,
            "mail":mail,
            "tel":tel,
            "num_Av":preferences.string(forKey: "idUser")!,
            "image":image,
            "AvocatAdversaire":AvocatAdversaire
        ]
        Alamofire.request(Connexion.adresse + "/api/Adversaire/AddAdversaire", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
                let result = response.result.value as! String
                
                completion(result)
            }
        }
    }
    
    func uploadImage (image: Data, completion: @escaping (String) -> Void) {
        let preferences = UserDefaults.standard
        if( preferences.object(forKey: "token") != nil){
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image, withName: "file", fileName:"image.jpg" , mimeType: "image/jpeg")
            },
                to: Connexion.adresse + "/api/Adversaire/UploadImage",
                headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            print(response.result.value as! String)
                            completion(response.result.value as! String)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                        completion("failure")
                    }
                    
            })
        }
    }
    
    
    
    }

