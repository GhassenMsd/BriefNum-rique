//
//  DemandeDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 06/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandeDetailsViewController: UIViewController {

    var idDemande = ""
    var demande = Demande()

    @IBOutlet var dateDemande: UILabel!
    @IBOutlet var PartieCD: UILabel!
    @IBOutlet var typeD: UILabel!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet var sujetDemande: UITextView!
    @IBOutlet weak var ViewDemande: UIView!
    
    @objc func fetchdemandeDetail() -> Void {
        let demandeservices = DemandeService()
        demandeservices.getDemandeById(id: idDemande){ (demande) in
            self.navbar.title = demande.nomDemande
            self.dateDemande.text = String(demande.date.prefix(10))
            self.PartieCD.text = demande.partieConcernee
            self.typeD.text = demande.type
            self.sujetDemande.text = demande.sujet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdemandeDetail()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchdemandeDetail), name: NSNotification.Name(rawValue: "fetchdemandeDetail"), object: nil)
        
        ViewDemande.addShadowView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMatleb"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchDemande"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toUpdateMatleb"{
                if let updateDemande = segue.destination as? DemandeUpdateViewController {
                    updateDemande.demande = self.demande
                }
        }
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
