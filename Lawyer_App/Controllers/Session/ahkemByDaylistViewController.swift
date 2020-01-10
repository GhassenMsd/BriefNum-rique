//
//  ahkemByDayListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 04/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class ahkemByDayListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var sessionsList : Array<Session> = []
    var idAffaire = ""

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var ahkemTableView: UITableView!

    
    @IBOutlet var ahkemnon: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Home.sessionByDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell")
        let contentView = cell?.viewWithTag(0)
        
        let hokmName = contentView?.viewWithTag(2) as! UILabel
        let Jalsa = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        hokmName.text = Home.sessionByDate[indexPath.row].Disp_prep
        Jalsa.text = Home.sessionByDate[indexPath.row].nomSession
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAhkemSessionDetails"{
            let index = sender as! NSIndexPath
            if let sessionDayDetailsViewController = segue.destination as? SessionDayDetailViewController {
                sessionDayDetailsViewController.session = Home.sessionByDate[index.row]

            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toAhkemSessionDetails", sender: indexPath)
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
