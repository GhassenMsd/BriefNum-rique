//
//  AffaireDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 02/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Floaty

class AffaireDetailsViewController: UIViewController {

    @IBOutlet var floaty: Floaty!
    
    @IBOutlet weak var ViewInfo: UIView!
    @IBOutlet weak var ViewObjectif: UIView!
    @IBOutlet weak var ViewAffaire: UIView!
    @IBOutlet weak var ViewDemande: UIView!
    
    @IBOutlet var cercle: UILabel!
    @IBOutlet var SujetAffaire: UITextView!
    @IBOutlet weak var numeroAff: UILabel!
    @IBOutlet weak var SessionName: UILabel!
    @IBOutlet var SessionDate: UILabel!
    @IBOutlet weak var AllSession: UILabel!
    @IBOutlet weak var ObjectifName: UILabel!
    @IBOutlet var ObjectifDate: UILabel!
    @IBOutlet weak var AllObjectif: UILabel!
    @IBOutlet weak var DemandeName: UILabel!
    @IBOutlet var JihaDemande: UILabel!
    @IBOutlet weak var AllDemande: UILabel!
    
    @IBOutlet weak var navbar: UINavigationItem!
    
    
    var affaire = Affaire()
    let sessionService = SessionService()
    let missionService = MissionService()
    let demandeService = DemandeService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = "قظية " + affaire.numAff
        //detailsAffaire
        self.numeroAff.text = affaire.numAff
        self.SujetAffaire.text = affaire.sujet
        self.cercle.text = affaire.cercle
        
        //SessionRecente
        sessionService.getAllByAffaire(idAffaire: affaire.numAff){ (sessions) in
            self.SessionName.text = sessions[0].nomSession
            self.SessionDate.text = sessions[0].date
        }
        
        //MissionRecente
        missionService.getAllByAffaire(idAffaire: affaire.numAff){ (missions) in
            self.ObjectifName.text = missions[0].nomMission
            self.ObjectifDate.text = missions[0].date
        }
        
        //DemandeRecente
        demandeService.getAllByAffaire(idAffaire: affaire.numAff){ (demandes) in
            self.DemandeName.text = demandes[0].nomDemande
            self.JihaDemande.text = demandes[0].partieConcernee
        }
        
        
        
        
        
        ViewInfo.addShadowView()
        ViewAffaire.addShadowView()
        ViewObjectif.addShadowView()
        ViewDemande.addShadowView()
        let tapSession = UITapGestureRecognizer(target: self, action: #selector(tapSession(_:)))
        let tapSessionList = UITapGestureRecognizer(target: self, action: #selector(tapSessionList(_:)))
        let tapObjectif = UITapGestureRecognizer(target: self, action: #selector(tapObjectif(_:)))
        let tapObjectifList = UITapGestureRecognizer(target: self, action: #selector(tapObjectifList(_:)))
        let tapDemande = UITapGestureRecognizer(target: self, action: #selector(tapDemande(_:)))
        let tapDemandeList = UITapGestureRecognizer(target: self, action: #selector(tapDemandeList(_:)))

        
        AllSession.addGestureRecognizer(tapSessionList)
        AllObjectif.addGestureRecognizer(tapObjectifList)
        ViewAffaire.addGestureRecognizer(tapSession)
        ViewObjectif.addGestureRecognizer(tapObjectif)
        AllDemande.addGestureRecognizer(tapDemandeList)
        ViewDemande.addGestureRecognizer(tapDemande)
        
        
        floaty.addItem("إضافة مهمة", icon: UIImage(named: "Groupe 584")!,handler: { _ in
            self.performSegue(withIdentifier: "AjoutMission", sender: self)
        })
        floaty.addItem("إضافة مطلب", icon: UIImage(named: "Groupe 583")!,handler: { _ in
            self.performSegue(withIdentifier: "AjoutDemande", sender: self)
        })
        floaty.addItem("إضافة جلسة", icon: UIImage(named: "Groupe 582")!,handler: { _ in
            self.performSegue(withIdentifier: "AjoutSession", sender: self)
        })

        self.view.addSubview(floaty)

        // Do any additional setup after loading the view.
    }
    
   
    
    @objc func tapDemande(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDemande", sender: DemandeName)
    }
    
    @objc func tapDemandeList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toListDemande", sender: nil)
    }
    
    @objc func tapSession(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toSession", sender: SessionName)
    }
    
    @objc func tapSessionList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toListSession", sender: nil)
    }
    
    @objc func tapObjectifList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toListObjectif", sender: nil)
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
        else if segue.identifier == "toDemande"{
            let label = sender as! UILabel
            if let demandeDetailsViewController = segue.destination as? DemandeDetailsViewController {
                demandeDetailsViewController.nomDemande = label.text!
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
