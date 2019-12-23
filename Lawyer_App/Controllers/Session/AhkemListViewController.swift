//
//  AhkemListViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/23/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AhkemListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let sessionService = SessionService()
    var sessionsList : Array<Session> = []
    var idAffaire = ""

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var ahkemTableView: UITableView!

    
    @IBOutlet var ahkemnon: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell")
        let contentView = cell?.viewWithTag(0)
        
        let hokmName = contentView?.viewWithTag(2) as! UILabel
        let Jalsa = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        hokmName.text = sessionsList[indexPath.row].Disp_prep
        Jalsa.text = sessionsList[indexPath.row].nomSession
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionService.getAllByAffaire(idAffaire: idAffaire){ (sessions) in
            if (sessions.count == 0){
                self.ahkemnon.text = "ليس لديك أحكام"
            }else{
                self.sessionsList = sessions
                self.ahkemTableView.reloadData()
                self.ahkemnon.isHidden = true
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAhkemSessionDetails"{
            let cell = sender as! UITableViewCell
            print(cell)
            let index = ahkemTableView.indexPath(for: cell)! as NSIndexPath
            if let sessionDetailsViewController = segue.destination as? SessionViewController {
                sessionDetailsViewController.session = sessionsList[index.row]
                sessionDetailsViewController.idSession = String(sessionsList[index.row].id)

            }
        }
        else if(segue.identifier == "toAddSession"){
            if let sessionAddViewCtroller = segue.destination as? SessionAddViewController {
                sessionAddViewCtroller.idAffaire = self.idAffaire
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toAhkemSessionDetails", sender: ahkemTableView.cellForRow(at: indexPath))
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
