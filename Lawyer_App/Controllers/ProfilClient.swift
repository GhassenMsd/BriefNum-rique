//
//  ProfilClient.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/9/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ProfilClient: UIViewController {
    
    var name = ""

    
    @IBOutlet weak var cinView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var adresseView: UIView!
    @IBOutlet weak var emploiView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBAction func back(_ sender: Any) {
    
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cinView.addShadowView()
        dateView.addShadowView()
        birthView.addShadowView()
        adresseView.addShadowView()
        emploiView.addShadowView()
        mailView.addShadowView()
        homeView.addShadowView()
        nameView.addShadowView()
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
