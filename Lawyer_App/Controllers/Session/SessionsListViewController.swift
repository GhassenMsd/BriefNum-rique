//
//  SessionsListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        DateSession.text = sessionsList[indexPath.row].date
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذه الجلسة ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                self.sessionService.DeleteSession(id: String(self.sessionsList[indexPath.row].id)) { () in
                    self.sessionsList.remove(at: indexPath.row)
                    self.sessionsTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.sessionsTableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
                }
            }
            alert.addAction(yesAction)

            // cancel action
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
            
            print("delete")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSessionDetails"{
            let cell = sender as! UITableViewCell
            print(cell)
            let index = sessionsTableView.indexPath(for: cell)! as NSIndexPath
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
        
        performSegue(withIdentifier: "toSessionDetails", sender: sessionsTableView.cellForRow(at: indexPath))
    }
    

    @IBOutlet weak var AddSession: UIButton!
    @IBOutlet weak var sessionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AddSession.addShadowView()
        fetchJalsa()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchJalsa), name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchJalsa() -> Void {
        sessionService.getAllByAffaire(idAffaire: idAffaire){ (sessions) in
            if (sessions.count == 0){
                self.hideJalsa.text = "ليس لديك جلسات"
            }else{
                self.sessionsList = sessions
                self.sessionsTableView.reloadData()
                self.hideJalsa.isHidden = true
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
