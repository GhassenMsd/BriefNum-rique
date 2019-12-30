//
//  ListClients.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/10/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import SDWebImage

class ListClients: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var clients: Array<Client> = []
    let clientService = ClientService()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Home.clients.count
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        let contentView = cell?.viewWithTag(0)
        
        let cin = contentView?.viewWithTag(2) as! UILabel
        let img = contentView?.viewWithTag(8) as! UIImageView
        
        let mail = contentView?.viewWithTag(3) as! UILabel
        let name = contentView?.viewWithTag(4) as! UILabel
        let view = contentView?.viewWithTag(1)!

        view!.addShadowView()

        cin.text = Home.clients[indexPath.row].cin_pass
        
        img.sd_imageIndicator = SDWebImageActivityIndicator.gray

        img.sd_setImage(with: URL(string: Connexion.adresse + "/Ressources/Client/" + Home.clients[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        
        img.addShadowView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        mail.text = Home.clients[indexPath.row].mail
        name.text = Home.clients[indexPath.row].nomComplet
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsClient", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsClient"{
            let index = sender as! NSIndexPath
            if segue.destination is ProfilClient {
                ProfilClient.client = Home.clients[index.row]
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(fetchClients), name: NSNotification.Name(rawValue: "fetchClients"), object: nil)

    }
    
    @IBOutlet weak var ClientTableView: UITableView!
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let alert = UIAlertController(title: nil, message: "هل تريد حقاً حذف هذا الحريف ؟", preferredStyle: .alert)

            // yes action
            let yesAction = UIAlertAction(title: "تأكيد", style: .default) { _ in
                // replace data variable with your own data array
                self.clientService.deleteClient(id: Home.clients[indexPath.row].id) { _ in
                    Home.clients.remove(at: indexPath.row)
                    self.ClientTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    self.ClientTableView.reloadData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchClient"), object: nil)
                }
            }
            alert.addAction(yesAction)

            // cancel action
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
            
            print("delete")
        }
    }
    
    @objc func fetchClients(){
        ClientTableView.reloadData()
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
