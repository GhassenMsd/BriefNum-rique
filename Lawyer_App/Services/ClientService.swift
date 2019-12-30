//
//  ClientService.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 19/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class ClientService: NSObject {
    
    override init() {
    }
    
    func getAll (completion: @escaping (Array<Client>) -> Void) {
    
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
       
        Alamofire.request(Connexion.adresse + "/api/Client/getAll/" + preferences.string(forKey: "idUser")!,encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON {
                response in
            var clients:Array<Client> = []
            for clientDict in response.result.value as! Array<Dictionary<String,Any>> {
                let client = Client(id:clientDict["id"] as! Int,nomComplet:clientDict["nomComplet"] as! String,cin_pass:clientDict["cin_pass"] as! String,dateEmission:clientDict["dateEmission"] as! String,tel:clientDict["tel"] as! String,dateNaissance:clientDict["dateNaissance"] as! String,lieuNaissance:clientDict["lieuNaissance"] as! String,adresse:clientDict["adresse"] as! String,proffession:clientDict["proffession"] as! String,mail:clientDict["mail"] as! String,id_Av:clientDict["id_Av"] as! Int,image:clientDict["image"] as! String,etat:clientDict["etat"] as! String)
                clients.append(client)
                /*let client: Client = Client(dictionary: clientDict)
                print("-----------")
                print(client)
                clients.append(client)*/
            }
            completion(clients)
            }
        }
    }
    
    func addClient(nomComplet: String, dateNaissance: String, lieuNaissance: String, cin_pass: String, dateEmission: String, proffession: String, adresse: String, mail: String, image: String, tel: String, completion: @escaping (String) -> Void){
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
            "id_Av":preferences.string(forKey: "idUser")!,
            "image":image
        ]
        Alamofire.request(Connexion.adresse + "/api/Client/AddClient", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
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
                to: Connexion.adresse + "/api/Client/UploadImage",
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
    
    func updateClient(id: Int, nomComplet: String, dateNaissance: String, lieuNaissance: String, cin_pass: String, dateEmission: String, proffession: String, adresse: String, mail: String, image: String, completion: @escaping (String) -> Void){
    let preferences = UserDefaults.standard
    if( preferences.object(forKey: "token") != nil){
        let parameters: Parameters = [
            "id": id,
            "nomComplet": nomComplet,
            "dateNaissance": dateNaissance,
            "lieuNaissance": lieuNaissance,
            "cin_pass": cin_pass,
            "dateEmission":dateEmission,
            "proffession":proffession,
            "adresse":adresse,
            "mail":mail,
            "image":image
        ]
        Alamofire.request(Connexion.adresse + "/api/Client/UpdateClient", method:.post, parameters:parameters,encoding: JSONEncoding.default, headers:["Authorization": "Bearer " + preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value)
                let result = response.result.value as! String
                
                completion(result)
            }
        }
    }

}
