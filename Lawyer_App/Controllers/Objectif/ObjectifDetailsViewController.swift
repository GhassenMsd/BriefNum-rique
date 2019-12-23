//
//  ObjectifDetailsViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 05/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ObjectifDetailsViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var DateObjectif: UILabel!
    
    @IBOutlet weak var ViewObjectif: UIView!
    @IBOutlet var PartieC: UILabel!
    @IBOutlet var type: UITextView!
    
    
    var idMission = ""
    var mission = Mission()

    @objc func fetchDetailsMission() -> Void {
        
        let missionServices = MissionService()
        missionServices.getMissionById(id: idMission){ (mission) in
            self.navBar.title = mission.nomMission
            self.DateObjectif.text = mission.date
            self.PartieC.text = mission.partieConsernee
            self.type.text = mission.type
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewObjectif.addShadowView()
        fetchDetailsMission()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchDetailsMission), name: NSNotification.Name(rawValue: "fetchDetailsMission"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMohema"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMission"), object: nil)
            self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toUpdate"{
                if let updateMission = segue.destination as? ObjectifUpdateViewController {
                    updateMission.mission = self.mission
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
