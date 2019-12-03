//
//  SessionsListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSessionDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell")
        let contentView = cell?.viewWithTag(0)
        
        let SessionName = contentView?.viewWithTag(2) as! UILabel
        let DateSession = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        SessionName.text = dataSession[indexPath.row]
        DateSession.text = dataSessionDate[indexPath.row]
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSessionDetails"{
            let cell = sender as! UITableViewCell
            print(cell)
            let index = sessionsTableView.indexPath(for: cell)! as NSIndexPath
            if let sessionDetailsViewController = segue.destination as? SessionViewController {
                sessionDetailsViewController.nomSess = dataSession[index.row]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toSessionDetails", sender: sessionsTableView.cellForRow(at: indexPath))
    }
    

    let dataSession = ["جلسة 1","جلسة 2"]
    let dataSessionDate = ["10/01/2019","16/01/2019"]
    
    @IBOutlet weak var AddSession: UIButton!
    @IBOutlet weak var sessionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AddSession.addShadowView()
        // Do any additional setup after loading the view.
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
