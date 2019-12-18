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

    @IBOutlet weak var AffairesTableView: UITableView!
    @IBOutlet weak var ViewSearch: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSearch.addShadowView()
        
        affaireService.getAll() { (affaires) in
            self.affairesList = affaires
            self.AffairesTableView.reloadData()
        }
        
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

            numAffaire.text =  "قظية " + affairesList[indexPath.row].numAff
            tribunal.text = affairesList[indexPath.row].degre
            cercle.text = affairesList[indexPath.row].cercle
        
        
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            let cell = sender as! UITableViewCell
            let index = AffairesTableView.indexPath(for: cell)! as NSIndexPath
            if let affaireDetailsViewController = segue.destination as? AffaireDetailsViewController {
                affaireDetailsViewController.nomAffaire = affairesList[index.row].nameAff
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
