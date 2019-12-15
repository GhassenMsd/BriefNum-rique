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
                completion(User(id: 0,nomComplet: "",grade: "",adresseBureau: "",tel: "",img: "",password: "",token: ""))
            }
            else{
                let userDict = responseDict["user"] as! Dictionary<String,Any>
                
                let preferences = UserDefaults.standard
                preferences.setValue(responseDict["token"] as! String, forKey: "token")
                //  Save to disk
                let didSave = preferences.synchronize()
                if !didSave {
                    print("matsabbech")
                    //  Couldn't save (I've never seen this happen in real world testing)
                }
                completion(User(id: userDict["id"] as! Int ,nomComplet: userDict["nomComplet"] as! String,grade: userDict["grade"] as! String ,adresseBureau: userDict["adresseBureau"] as! String ,tel: userDict["tel"] as! String ,img: userDict["img"] as! String ,password: userDict["password"] as! String ,token: responseDict["token"] as! String))
            }
        }
    }

}
