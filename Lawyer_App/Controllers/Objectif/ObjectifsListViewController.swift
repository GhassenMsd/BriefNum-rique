//
//  ObjectifsListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 05/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ObjectifsListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    let missionsService = MissionService()
    var missionsList : Array<Mission> = []
    var idAffaire = ""
    
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
        ObjectifSession.text = missionsList[indexPath.row].date
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toObjectifDetails"{
            let cell = sender as! UITableViewCell
            
            let index = ObjectifTableView.indexPath(for: cell)! as NSIndexPath
            if let objectifDetailsViewController = segue.destination as? ObjectifDetailsViewController {
                objectifDetailsViewController.mission = missionsList[index.row]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toObjectifDetails", sender: ObjectifTableView.cellForRow(at: indexPath))
    }
    

    @IBOutlet weak var ObjectifTableView: UITableView!
    @IBOutlet weak var addObjectif: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addObjectif.addShadowView()
        
        missionsService.getAllByAffaire(idAffaire: idAffaire){ (missions) in
            self.missionsList = missions
            self.ObjectifTableView.reloadData()
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
