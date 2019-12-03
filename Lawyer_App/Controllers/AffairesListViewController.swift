//
//  AffairesListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 30/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AffairesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let dataAffaires = ["قضية 1484675477","قضية 0781165477","قضية 0081925477","قضية 0780065103"]
    let dataTribunal = ["محكمة بن عروس","محكمة باب سعدون","محكمة باب سعدون","محكمة بن عروس"]
    let datacercle = ["دائرة تونس 1","دائرة تونس 2","دائرة تونس 2","دائرة تونس 1"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAffaires.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "affaireCell")
        let contentView = cell?.viewWithTag(0)
        
        let numAffaire = contentView?.viewWithTag(5) as! UILabel
        let tribunal = contentView?.viewWithTag(6) as! UILabel
        let cercle = contentView?.viewWithTag(7) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        
        
        numAffaire.text = dataAffaires[indexPath.row]
        tribunal.text = dataTribunal[indexPath.row]
        cercle.text = datacercle[indexPath.row]
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetails"{
            let cell = sender as! UITableViewCell
            let index = AffairesTableView.indexPath(for: cell)! as NSIndexPath
            if let affaireDetailsViewController = segue.destination as? AffaireDetailsViewController {
                affaireDetailsViewController.numAff = dataAffaires[index.row]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetails", sender: AffairesTableView.cellForRow(at: indexPath))
        
    }
    
    @IBOutlet weak var AffairesTableView: UITableView!
    @IBOutlet weak var ViewSearch: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSearch.addShadowView()
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
