//
//  DemandesListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 06/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class DemandesListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    let demandeservice = DemandeService()
    var demandesList : Array<Demande> = []
    var idAffaire = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demandesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemandeCell")
        let contentView = cell?.viewWithTag(0)
        
        let DemandeName = contentView?.viewWithTag(2) as! UILabel
        let DemandeClient = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        DemandeName.text = demandesList[indexPath.row].nomDemande
        DemandeClient.text = demandesList[indexPath.row].partieConcernee
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDemandeDetails"{
            let cell = sender as! UITableViewCell
            
            let index = DemandesTableView.indexPath(for: cell)! as NSIndexPath
            if let demandeDetailsViewController = segue.destination as? DemandeDetailsViewController {
                demandeDetailsViewController.demande = demandesList[index.row]
            }
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDemandeDetails", sender: DemandesTableView.cellForRow(at: indexPath))
    }

    @IBOutlet weak var DemandesTableView: UITableView!
    @IBOutlet weak var addDemande: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDemande.addShadowView()
        
        
        demandeservice.getAllByAffaire(idAffaire: idAffaire){ (demandes) in
            self.demandesList = demandes
            self.DemandesTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
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
