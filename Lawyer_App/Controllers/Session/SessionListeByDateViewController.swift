//
//  SessionListeByDateViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 29/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionListeByDateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let sessionService = SessionService()
    var sessionsList : Array<Session> = []
    var idAffaire = ""
    @IBOutlet var hideJalsa: UILabel!
    

    @IBAction func BackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchSession"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell")
        let contentView = cell?.viewWithTag(0)
        
        let SessionName = contentView?.viewWithTag(2) as! UILabel
        let DateSession = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        SessionName.text = sessionsList[indexPath.row].nomSession
        DateSession.text = String(sessionsList[indexPath.row].date.prefix(10))
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailSessionDay"{
            
            let index = sender as! NSIndexPath
            if let sessionDayDetailsViewController = segue.destination as? SessionDayDetailViewController {
                sessionDayDetailsViewController.session = sessionsList[index.row]
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetailSessionDay", sender: indexPath)
    }
    
    @IBOutlet weak var sessionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchJalsa()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(fetchJalsa), name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    /*@objc func fetchJalsa() -> Void {
        sessionService.getAllByAffaire(idAffaire: idAffaire){ (sessions) in
            if (sessions.count == 0){
                self.hideJalsa.text = "ليس لديك جلسات"
                self.hideJalsa.isHidden = false
            }else{
                self.sessionsList = sessions
                self.sessionsTableView.reloadData()
                self.hideJalsa.isHidden = true
            }
            
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
