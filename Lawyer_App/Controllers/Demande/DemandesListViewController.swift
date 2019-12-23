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
    
    @IBOutlet var hideMatleb: UILabel!
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذا الطلب ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                self.demandeservice.DeleteDemande(id: String(self.demandesList[indexPath.row].id)) { () in
                    self.demandesList.remove(at: indexPath.row)
                    self.DemandesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.DemandesTableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchMatleb"), object: nil)
                }
            }
            alert.addAction(yesAction)

            // cancel action
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDemandeDetails"{
            let cell = sender as! UITableViewCell
            
            let index = DemandesTableView.indexPath(for: cell)! as NSIndexPath
            if let demandeDetailsViewController = segue.destination as? DemandeDetailsViewController {
                demandeDetailsViewController.demande = demandesList[index.row]
                demandeDetailsViewController.idDemande = String(demandesList[index.row].id)
            }
        }
        if segue.identifier == "ToAjoutDemande"{
                if let ajoutDemande = segue.destination as? DemandeAddViewController {
                    ajoutDemande.idAffaire = self.idAffaire
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
        fetchMatleb()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchMatleb), name: NSNotification.Name(rawValue: "fetchMatleb"), object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func fetchMatleb() -> Void {
        demandeservice.getAllByAffaire(idAffaire: idAffaire){ (demandes) in
            if(demandes.count == 0){
                self.hideMatleb.text = "ليس لديك مطالب"
            }else{
                self.demandesList = demandes
                self.DemandesTableView.reloadData()
                self.hideMatleb.isHidden = true
            }
            
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchDemande"), object: nil)
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
