//
//  MissionDayDetailViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 30/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class MissionDayDetailViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var DateObjectif: UILabel!
    
    @IBOutlet weak var ViewObjectif: UIView!
    @IBOutlet var PartieC: UILabel!
    @IBOutlet var type: UITextView!
    
    var mission = Mission()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewObjectif.addShadowView()
        self.navBar.title = mission.nomMission
        self.DateObjectif.text = String(mission.date.prefix(10))
        self.PartieC.text = mission.partieConsernee
        self.type.text = mission.type
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
