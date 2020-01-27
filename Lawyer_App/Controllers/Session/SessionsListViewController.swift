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
    var selectedCell:Int!
    typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
    let refreshControl = UIRefreshControl()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .large)

    

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
        //let send = contentView?.viewWithTag(5) as! UIImageView
        let view = contentView?.viewWithTag(1)!
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
        cell?.contentView.viewWithTag(5)?.isUserInteractionEnabled = true
        cell?.contentView.viewWithTag(5)?.addGestureRecognizer(tapImage)
        cell?.contentView.viewWithTag(5)?.tag = indexPath.row

        
        view!.addShadowView()
        SessionName.text = "جلسة " + sessionsList[indexPath.row].date
        DateSession.text = sessionsList[indexPath.row].nom
        
        

        
        
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    @objc func tapImage(_ sender:UITapGestureRecognizer) {
        self.selectedCell = sender.view?.tag
        performSegue(withIdentifier: "Send", sender: nil)
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
                    self.sessionsTableView.reloadWithAnimation()
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
            
            
        }else if(segue.identifier == "Send"){
            if let ListAvocats = segue.destination as? ListAvocatsViewController {
                ListAvocats.dateSession = String(sessionsList[self.selectedCell].date.prefix(10))
                ListAvocats.idTrib = sessionsList[self.selectedCell].tribunal
                ListAvocats.tribunalName = sessionsList[self.selectedCell].nom
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
        
        refreshControl.addTarget(self, action: #selector(fetchJalsa), for: .valueChanged)
        spinner.startAnimating()
        sessionsTableView.backgroundView = spinner
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        sessionsTableView.refreshControl = refreshControl
        
        fetchJalsa()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchJalsa), name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchJalsa() -> Void {
        sessionService.getAllByAffaire(idAffaire: idAffaire){ (sessions) in
            if (sessions.count == 0){
                self.hideJalsa.text = "ليس لديك جلسات"
                self.hideJalsa.isHidden = false
            }else{
                self.sessionsList = sessions
                self.sessionsTableView.reloadWithAnimation()
                self.hideJalsa.isHidden = true
                self.refreshControl.endRefreshing()
                self.spinner.stopAnimating()

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



extension UITableView {
func reloadWithAnimation() {
    self.reloadData()
    let tableViewHeight = self.bounds.size.height
    let cells = self.visibleCells
    var delayCounter = 0
    for cell in cells {
        cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
    for cell in cells {
        UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
        delayCounter += 1
    }
}
}

