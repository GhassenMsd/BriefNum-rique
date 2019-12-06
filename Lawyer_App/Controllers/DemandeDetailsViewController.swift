//
//  DemandeDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 06/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandeDetailsViewController: UIViewController {

    var nomDemande = ""
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var ViewDemande: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = nomDemande
        ViewDemande.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
