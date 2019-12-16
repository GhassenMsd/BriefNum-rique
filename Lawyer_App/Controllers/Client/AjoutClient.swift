//
//  AjoutClient.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/10/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AjoutClient: UIViewController {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewCin: UIView!
    @IBOutlet weak var viewDateCin: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewplace: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewAdress: UIView!
    @IBOutlet weak var viewMet: UIView!
    @IBOutlet weak var viewMail: UIView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCin.addShadowView()
        viewDateCin.addShadowView()
        viewDate.addShadowView()
        viewplace.addShadowView()
        viewName.addShadowView()
        viewAdress.addShadowView()
        viewMet.addShadowView()
        viewMail.addShadowView()
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
        
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
