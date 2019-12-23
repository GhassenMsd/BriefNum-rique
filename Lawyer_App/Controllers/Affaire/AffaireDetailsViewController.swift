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
    var refreshControl = UIRefreshControl()

    @IBOutlet var floaty: Floaty!
    
    @IBOutlet weak var ViewInfo: UIView!
    @IBOutlet weak var ViewObjectif: UIView!
    @IBOutlet weak var ViewAffaire: UIView!
    @IBOutlet weak var ViewDemande: UIView!
    @IBOutlet var ahkemView: UIView!
    
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
    @IBOutlet var ahkemText: UITextView!
    @IBOutlet var AllAhkem: UILabel!
    @IBOutlet var ahkemNo: UILabel!
    
    @IBOutlet weak var navbar: UINavigationItem!
    
    @IBOutlet var sessionNon: UILabel!
    @IBOutlet var misssionsNon: UILabel!
    @IBOutlet var demandeNon: UILabel!
    
    var affaire = Affaire()
    var sessionS = Session()
    var missionS = Mission()
    var demandeS = Demande()
    
    @objc func fetchDemande() -> Void {
        let demandeService = DemandeService()

        demandeService.getAllByAffaire(idAffaire: affaire.numAff){ (demandes) in
            if(demandes.count == 0){
                self.demandeNon.isHidden = false
                self.demandeNon.text = "ليس لديك مطالب"
                self.ViewDemande.isHidden = true
            }else{
                self.demandeS = demandes[0]
                self.DemandeName.text = demandes[0].nomDemande
                self.JihaDemande.text = demandes[0].partieConcernee
                self.demandeNon.isHidden = true
                self.ViewDemande.isHidden = false
            }
            
        }
    }
    
    @objc func fetchSession() -> Void {
        let sessionService = SessionService()

        sessionService.getAllByAffaire(idAffaire: affaire.numAff){ (sessions) in
            if (sessions.count == 0){
                self.sessionNon.isHidden = false
                self.ahkemNo.isHidden = false
                self.sessionNon.text = "ليس لديك جلسات"
                self.ahkemNo.text = "ليس لديك أحكام"
                self.ViewAffaire.isHidden = true
                self.ahkemView.isHidden = true

            }else{
                self.sessionS = sessions[0]
                self.SessionName.text = sessions[0].nomSession
                self.SessionDate.text = sessions[0].date
                self.ahkemText.text = sessions[0].Disp_prep
                
                self.sessionNon.isHidden = true
                self.ahkemNo.isHidden = true
                self.ahkemView.isHidden = false
                self.ViewAffaire.isHidden = false
            }
        }
    }
    
    @objc func fetchMission() -> Void {
        let missionService = MissionService()
        missionService.getAllByAffaire(idAffaire: affaire.numAff){ (missions) in
            print("miiiiiiiiii " + String(missions.count))
            if(missions.count == 0){
                self.misssionsNon.isHidden = false
                self.misssionsNon.text = "ليس لديك مهام"
                self.ViewObjectif.isHidden = true
            }else if (missions.count > 0){
                self.missionS = missions[0]
                self.ObjectifName.text = missions[0].nomMission
                self.ObjectifDate.text = missions[0].date
                self.misssionsNon.isHidden = true
                self.ViewObjectif.isHidden = false
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbar.title = "قظية " + affaire.numAff
        //detailsAffaire
        self.numeroAff.text = affaire.numAff
        self.SujetAffaire.text = affaire.sujet
        self.cercle.text = affaire.cercle
        
        //SessionRecente
        fetchSession()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSession), name: NSNotification.Name(rawValue: "fetchSession"), object: nil)
        
        //MissionRecente
        fetchMission()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchMission), name: NSNotification.Name(rawValue: "fetchMission"), object: nil)
        
        //DemandeRecente
        fetchDemande()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchDemande), name: NSNotification.Name(rawValue: "fetchDemande"), object: nil)
        
        
        
        
        
        ViewInfo.addShadowView()
        ViewAffaire.addShadowView()
        ViewObjectif.addShadowView()
        ViewDemande.addShadowView()
        ahkemView.addShadowView()
        let tapSession = UITapGestureRecognizer(target: self, action: #selector(tapSession(_:)))
        let tapSessionList = UITapGestureRecognizer(target: self, action: #selector(tapSessionList(_:)))
        let tapObjectif = UITapGestureRecognizer(target: self, action: #selector(tapObjectif(_:)))
        let tapObjectifList = UITapGestureRecognizer(target: self, action: #selector(tapObjectifList(_:)))
        let tapDemande = UITapGestureRecognizer(target: self, action: #selector(tapDemande(_:)))
        let tapDemandeList = UITapGestureRecognizer(target: self, action: #selector(tapDemandeList(_:)))

        
        let tapAhkem = UITapGestureRecognizer(target: self, action: #selector(tapAhkem(_:)))
        let tapAhkemListList = UITapGestureRecognizer(target: self, action: #selector(tapAhkemListList(_:)))
        
        AllSession.addGestureRecognizer(tapSessionList)
        AllObjectif.addGestureRecognizer(tapObjectifList)
        ViewAffaire.addGestureRecognizer(tapSession)
        ViewObjectif.addGestureRecognizer(tapObjectif)
        AllDemande.addGestureRecognizer(tapDemandeList)
        ViewDemande.addGestureRecognizer(tapDemande)
        AllAhkem.addGestureRecognizer(tapAhkemListList)
        ahkemView.addGestureRecognizer(tapAhkem)
        
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
    
    @objc func tapAhkemListList(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "tiListAhkem", sender: nil)
    }
    
    @objc func tapAhkem(_ gesture:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toSession", sender: ObjectifName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSession"{
            if let sessionViewController = segue.destination as? SessionViewController {
                sessionViewController.session = sessionS
                sessionViewController.idSession = String(sessionS.id)
            }
        }
        else if segue.identifier == "toObjectif"{
            if let objectifDetailsViewController = segue.destination as? ObjectifDetailsViewController {
                objectifDetailsViewController.idMission = String(missionS.id)
                objectifDetailsViewController.mission = missionS
            }
        }
        else if segue.identifier == "toDemande"{
            if let demandeDetailsViewController = segue.destination as? DemandeDetailsViewController {
                demandeDetailsViewController.demande = demandeS
                demandeDetailsViewController.idDemande = String(demandeS.id)
            }
        }
        
        else if segue.identifier == "toListSession"{
            if let sessionsListViewController = segue.destination as? SessionsListViewController {
                sessionsListViewController.idAffaire = affaire.numAff
            }
        }
            else if segue.identifier == "tiListAhkem"{
                if let ahkemListViewController = segue.destination as? AhkemListViewController {
                    ahkemListViewController.idAffaire = affaire.numAff
                }
            }
        else if segue.identifier == "toListObjectif"{
            if let objectifsListViewController = segue.destination as? ObjectifsListViewController {
                objectifsListViewController.idAffaire = affaire.numAff
            }
        }
        else if segue.identifier == "toListDemande"{
            if let demandesListViewController = segue.destination as? DemandesListViewController {
                demandesListViewController.idAffaire = affaire.numAff
            }
        }
        else if segue.identifier == "AjoutSession"{
            if let sessionAddViewController = segue.destination as? SessionAddViewController {
                sessionAddViewController.idAffaireFromHome = affaire.numAff
            }
        }
        else if segue.identifier == "AjoutMission"{
            if let objectifAddViewController = segue.destination as? ObjectifAddViewController {
                objectifAddViewController.idAffaireFromHome = affaire.numAff
            }
        }
        else if segue.identifier == "AjoutDemande"{
            if let demandeAddViewController = segue.destination as? DemandeAddViewController {
                demandeAddViewController.idAffaireFromHome = affaire.numAff
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
