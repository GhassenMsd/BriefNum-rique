//
//  DemandeDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 06/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandeDetailsViewController: UIViewController {

    var demande = Demande()

    @IBOutlet var dateDemande: UILabel!
    @IBOutlet var PartieCD: UILabel!
    @IBOutlet var typeD: UILabel!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet var sujetDemande: UITextView!
    @IBOutlet weak var ViewDemande: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = demande.nomDemande
        self.dateDemande.text = demande.date
        self.PartieCD.text = demande.partieConcernee
        self.typeD.text = demande.type
        self.sujetDemande.text = demande.sujet
        
        
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
