//
//  MissionDayListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 30/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class MissionDayListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

let missionsService = MissionService()
var missionsList : Array<Mission> = []
var idAffaire = ""

@IBOutlet var hideMohema: UILabel!
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return missionsList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectifCell")
    let contentView = cell?.viewWithTag(0)
    
    let ObjectifName = contentView?.viewWithTag(2) as! UILabel
    let ObjectifSession = contentView?.viewWithTag(3) as! UILabel
    let view = contentView?.viewWithTag(1)!

    view!.addShadowView()

    ObjectifName.text = missionsList[indexPath.row].nomMission
    ObjectifSession.text = String(missionsList[indexPath.row].date.prefix(10))
    //let exerciceName = contentView?.viewWithTag(3) as! UILabel
    return cell!

    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "toDetailMissionDay"{
        let index = sender as! NSIndexPath
        if let missionDayDetailsViewController = segue.destination as? MissionDayDetailViewController {
            missionDayDetailsViewController.mission = missionsList[index.row]
        }
    }
    
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "toDetailMissionDay", sender:indexPath)
}


@IBOutlet weak var ObjectifTableView: UITableView!
    
override func viewDidLoad() {
    super.viewDidLoad()
    if(missionsList.count == 0){
        self.hideMohema.text = "ليس لديك مهام"
        self.hideMohema.isHidden = false
    }
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
