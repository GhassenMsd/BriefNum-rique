//
//  AffaireDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 02/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AffaireDetailsViewController: UIViewController {

    @IBOutlet weak var numeroAff: UILabel!
    
    var numAff = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numeroAff.text = numAff
        ViewInfo.addShadowView()
        ViewAffaire.addShadowView()
        ViewObjectif.addShadowView()
        ViewDemande.addShadowView()
        let tapSession = UITapGestureRecognizer(target: self, action: #selector(tapSession(_:)))
        let tapSessionList = UITapGestureRecognizer(target: self, action: #selector(tapSessionList(_:)))
        let tapObjectif = UITapGestureRecognizer(target: self, action: #selector(tapObjectif(_:)))
        let tapObjectifList = UITapGestureRecognizer(target: self, action: #selector(tapObjectifList(_:)))

        AllSession.addGestureRecognizer(tapSessionList)
        AllObjectif.addGestureRecognizer(tapObjectifList)
        ViewAffaire.addGestureRecognizer(tapSession)
        ViewObjectif.addGestureRecognizer(tapObjectif)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ViewInfo: UIView!
    @IBOutlet weak var ViewObjectif: UIView!
    @IBOutlet weak var ViewAffaire: UIView!
    @IBOutlet weak var ViewDemande: UIView!
    @IBOutlet weak var SessionName: UILabel!
    @IBOutlet weak var AllSession: UILabel!
    @IBOutlet weak var ObjectifName: UILabel!
    @IBOutlet weak var AllObjectif: UILabel!
    
    @objc func tapSession(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toSession", sender: SessionName)
    }
    
    @objc func tapSessionList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toListSession", sender: SessionName)
    }
    
    @objc func tapObjectifList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toListObjectif", sender: SessionName)
    }
    
    @objc func tapObjectif(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toObjectif", sender: ObjectifName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSession"{
            let label = sender as! UILabel
            if let sessionViewController = segue.destination as? SessionViewController {
                sessionViewController.nomSess = label.text!
            }
        }
        else if segue.identifier == "toObjectif"{
            let label = sender as! UILabel
            if let objectifDetailsViewController = segue.destination as? ObjectifDetailsViewController {
                objectifDetailsViewController.Objectiftitle = label.text!
            }
        }
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
