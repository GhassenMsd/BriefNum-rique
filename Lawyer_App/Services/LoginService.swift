//
//  LoginService.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 15/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class LoginService : NSObject {
    
    let preferences = UserDefaults.standard

    
    override init() {
    }

    func login(email: String, password: String, completion: @escaping (User) -> Void){
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        Alamofire.request(Connexion.adresse + "/api/login", method:.post, parameters:parameters, headers:headers).responseJSON { response in
            print(response.result.value as Any)
            
            let responseDict = response.result.value as! Dictionary<String,Any>
            
            if( responseDict["token"] as! String == "" ){
                completion(User(id: 0,nomComplet: "",grade: "",adresseBureau: "",tel: "",img: "",password: "",token: "",email: ""))
            }
            else{
                let userDict = responseDict["user"] as! Dictionary<String,Any>
                let user = User(id: userDict["id"] as! Int ,nomComplet: userDict["nomComplet"] as! String,grade: userDict["grade"] as! String ,adresseBureau: userDict["adresseBureau"] as! String ,tel: userDict["tel"] as! String ,img: userDict["img"] as! String ,password: userDict["password"] as! String ,token: responseDict["token"] as! String,email: userDict["email"] as! String)
                
                self.preferences.setValue(responseDict["token"] as! String, forKey: "token")
                self.preferences.setValue(user.id, forKey: "idUser")
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
                self.preferences.setValue(encodedData, forKey: "user")

                //  Save to disk
                let didSave = self.preferences.synchronize()
                if !didSave {
                    print("matsabbech")
                    //  Couldn't save (I've never seen this happen in real world testing)
                }
                
                completion(user)
            }
        }
    }
    
    func UpdateUser(user: User, completion: @escaping (String) -> Void){
        
        let parameters: Parameters = [
            "id": user.id,
            "nomComplet": user.nomComplet,
            "grade": user.grade,
            "adresseBureau": user.adresseBureau,
            "tel": user.tel,
            "email": user.email,
            "img": user.img
        ]
        
        Alamofire.request(Connexion.adresse + "/api/Avocat/Update", method:.put, parameters:parameters, headers: ["Authorization": "Bearer " + self.preferences.string(forKey: "token")!]).responseJSON { response in
            print(response.result.value as Any)
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            self.preferences.setValue(encodedData, forKey: "user")

            completion(response.result.value as! String)
        }
    }

}
