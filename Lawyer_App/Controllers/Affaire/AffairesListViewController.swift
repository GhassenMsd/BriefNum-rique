//
//  AffairesListViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 30/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class AffairesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .large)

    let affaireService = AffaireService()
    var affairesList : Array<Affaire> = []
    var affairesListFiltre : Array<Affaire> = []
    let refreshControl = UIRefreshControl()

    @IBOutlet var rechercheText: UITextField!
    @IBOutlet var addAf: UIButton!
    @IBOutlet var KadhayaNon: UILabel!
    @IBOutlet weak var AffairesTableView: UITableView!
    @IBOutlet weak var ViewSearch: UIView!
    
    @objc func fetchAffaire() -> Void {
        affaireService.getAll() { (affaires) in
            if (affaires.count == 0){
                self.KadhayaNon.text = "ليس لديك قضايا"
            }else{
                self.affairesList = affaires
                self.affairesListFiltre = affaires
                self.AffairesTableView.reloadWithAnimation()
                self.refreshControl.endRefreshing()
                self.spinner.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSearch.addShadowView()
        refreshControl.addTarget(self, action: #selector(fetchAffaire), for: .valueChanged)
        spinner.startAnimating()
        AffairesTableView.backgroundView = spinner
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        AffairesTableView.refreshControl = refreshControl
        
        fetchAffaire()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchAffaire), name: NSNotification.Name(rawValue: "fetchAffaire"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return affairesListFiltre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "affaireCell")
        let contentView = cell?.viewWithTag(0)
    
        let numAffaire = contentView?.viewWithTag(5) as! UILabel
        let tribunal = contentView?.viewWithTag(6) as! UILabel
        let cercle = contentView?.viewWithTag(7) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        numAffaire.text =  "قظية " + String(affairesListFiltre[indexPath.row].numeroAffaire)
            tribunal.text = affairesListFiltre[indexPath.row].tribunal
            cercle.text = affairesListFiltre[indexPath.row].cercle
        
        
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذه القضية ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                
                self.affaireService.DeleteAffaire(id: String(self.affairesListFiltre[indexPath.row].numAff)){ () in
                    self.affairesListFiltre.remove(at: indexPath.row)
                    self.AffairesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.AffairesTableView.reloadWithAnimation()
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
            let index = sender as! NSIndexPath
            if let affaireDetailsViewController = segue.destination as? AffaireDetailsViewController {
                affaireDetailsViewController.affaire = affairesListFiltre[index.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetails", sender: indexPath)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAffaire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        spinner.startAnimating()
        AffairesTableView.backgroundView = spinner
        affairesList = []
        affairesListFiltre = []
        self.rechercheText.text = ""
        AffairesTableView.reloadData()
    }

    @IBAction func toAddAffaire(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddAffaire", sender: self)
    }
    
    @IBAction func rechercheAffaire(_ sender: Any) {
        if(self.rechercheText.text! != ""){
            self.affairesListFiltre = self.affairesList.filter { (affaire) -> Bool in
                return affaire.cercle.uppercased().contains(self.rechercheText.text!.uppercased()) || affaire.tribunal.uppercased().contains(self.rechercheText.text!.uppercased()) || affaire.numeroAffaire.description.contains(self.rechercheText.text!.uppercased())
            }
        }
        else{
            self.affairesListFiltre = self.affairesList
        }
        AffairesTableView.reloadData()
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
