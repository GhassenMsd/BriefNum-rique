//
//  RendezVousListeViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class RendezVousListeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: "fetchRendezVousListe"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RDVCollectionView.reloadWithAnimation()
    }
    
    
    @IBOutlet weak var RDVCollectionView: UITableView!
    @IBOutlet weak var addRDV: UIButton!
    @IBOutlet weak var RDVVide: UILabel!
    let rendezVousService = RendezVousService()
    var idAffaire = ""

    
    @objc func fetchData(){
        RDVCollectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Home.rendezVousByDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RendezVousCell")
        let contentView = cell?.viewWithTag(0)
        
        let ObjectifName = contentView?.viewWithTag(2) as! UILabel
        let ObjectifSession = contentView?.viewWithTag(3) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        ObjectifName.text = Home.rendezVousByDate[indexPath.row].nom
        ObjectifSession.text = String(Home.rendezVousByDate[indexPath.row].date.prefix(10))
        //let exerciceName = contentView?.viewWithTag(3) as! UILabel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsRDV", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsRDV"{
            let index = sender as! NSIndexPath
            if let rdvDetailsController = segue.destination as? RendezVousDetailsViewController{
                rdvDetailsController.rendezVous = Home.rendezVousByDate[index.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذا الموعد ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                self.rendezVousService.deleteRendezVous(id: Home.rendezVousByDate[indexPath.row].id) { _ in
                    Home.rendezVousByDate.remove(at: indexPath.row)
                    self.RDVCollectionView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchRendezVous"), object: nil)
                    self.RDVCollectionView.reloadData()


                }
            }
            alert.addAction(yesAction)

            // cancel action
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
            
            
        }
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
