//
//  AffairesListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 30/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AffairesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let affaireService = AffaireService()
    var affairesList : Array<Affaire> = []

    @IBOutlet var KadhayaNon: UILabel!
    @IBOutlet weak var AffairesTableView: UITableView!
    @IBOutlet weak var ViewSearch: UIView!
    
    @objc func fetchAffaire() -> Void {
        affaireService.getAll() { (affaires) in
            if (affaires.count == 0){
                self.KadhayaNon.text = "ليس لديك قضايا"
            }else{
                self.affairesList = affaires
                self.AffairesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSearch.addShadowView()
        
        fetchAffaire()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchAffaire), name: NSNotification.Name(rawValue: "fetchAffaire"), object: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return affairesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "affaireCell")
        let contentView = cell?.viewWithTag(0)
    
        let numAffaire = contentView?.viewWithTag(5) as! UILabel
        let tribunal = contentView?.viewWithTag(6) as! UILabel
        let cercle = contentView?.viewWithTag(7) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        numAffaire.text =  "قظية " + String(affairesList[indexPath.row].numeroAffaire)
            tribunal.text = affairesList[indexPath.row].tribunal
            cercle.text = affairesList[indexPath.row].cercle
        
        
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذه القضية ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                
                self.affaireService.DeleteAffaire(id: String(self.affairesList[indexPath.row].numAff)){ () in
                    self.affairesList.remove(at: indexPath.row)
                    self.AffairesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.AffairesTableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchAffaire"), object: nil)
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
        if segue.identifier == "toDetails"{
            let cell = sender as! UITableViewCell
            let index = AffairesTableView.indexPath(for: cell)! as NSIndexPath
            if let affaireDetailsViewController = segue.destination as? AffaireDetailsViewController {
                affaireDetailsViewController.affaire = affairesList[index.row]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetails", sender: AffairesTableView.cellForRow(at: indexPath))
        
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
