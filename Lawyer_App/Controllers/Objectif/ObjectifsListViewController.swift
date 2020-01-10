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
    let refreshControl = UIRefreshControl()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .large)

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
        ObjectifSession.text = missionsList[indexPath.row].date
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذه المهمة ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                self.missionsService.DeleteMission(id: String(self.missionsList[indexPath.row].id)) { () in
                    self.missionsList.remove(at: indexPath.row)
                    self.ObjectifTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.ObjectifTableView.reloadWithAnimation()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMohema"), object: nil)

                }
            }
            alert.addAction(yesAction)

            // cancel action
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toObjectifDetails"{
            let cell = sender as! UITableViewCell
            
            let index = ObjectifTableView.indexPath(for: cell)! as NSIndexPath
            if let objectifDetailsViewController = segue.destination as? ObjectifDetailsViewController {
                objectifDetailsViewController.idMission = String(missionsList[index.row].id)
                objectifDetailsViewController.mission = missionsList[index.row]
            }
        }
        if segue.identifier == "ToAjoutMission"{
                if let ajoutMissionn = segue.destination as? ObjectifAddViewController {
                    ajoutMissionn.idAffaire = self.idAffaire
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
        
        refreshControl.addTarget(self, action: #selector(fetchMohema), for: .valueChanged)
        spinner.startAnimating()
        ObjectifTableView.backgroundView = spinner
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        ObjectifTableView.refreshControl = refreshControl
        
        
        fetchMohema()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchMohema), name: NSNotification.Name(rawValue: "fetchMohema"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchMohema() -> Void {
        missionsService.getAllByAffaire(idAffaire: idAffaire){ (missions) in
            if(missions.count == 0){
                self.hideMohema.text = "ليس لديك مهام"
                self.hideMohema.isHidden = false
            }else{
                self.missionsList = missions
                self.ObjectifTableView.reloadWithAnimation()
                self.hideMohema.isHidden = true
                self.refreshControl.endRefreshing()
                self.spinner.stopAnimating()
            }
            
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMission"), object: nil)
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
