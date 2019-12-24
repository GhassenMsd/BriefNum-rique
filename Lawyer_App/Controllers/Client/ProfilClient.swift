//
//  ProfilClient.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/9/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ProfilClient: UIViewController {
    
    static var client:Client = Client()
    
    @IBOutlet weak var cinView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var adresseView: UIView!
    @IBOutlet weak var emploiView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nomComplet: UILabel!
    @IBOutlet weak var dateNaiss: UILabel!
    @IBOutlet weak var lieuNaiss: UILabel!
    @IBOutlet weak var cin_pass: UILabel!
    @IBOutlet weak var dateEmiss: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var adresse: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBAction func back(_ sender: Any) {
    
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cinView.addShadowView()
        dateView.addShadowView()
        birthView.addShadowView()
        adresseView.addShadowView()
        emploiView.addShadowView()
        mailView.addShadowView()
        homeView.addShadowView()
        nameView.addShadowView()
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + ProfilClient.client.image)!)
        imageUser.contentMode = .scaleAspectFill
        nomComplet.text = ProfilClient.client.nomComplet
        dateNaiss.text = String(ProfilClient.client.dateNaissance.prefix(10))
        lieuNaiss.text = ProfilClient.client.lieuNaissance
        cin_pass.text = ProfilClient.client.cin_pass
        dateEmiss.text = String(ProfilClient.client.dateEmission.prefix(10))
        profession.text = ProfilClient.client.proffession
        adresse.text = ProfilClient.client.adresse
        email.text = ProfilClient.client.mail
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func toUpdateBtn(_ sender: Any) {
        performSegue(withIdentifier: "toUpdateClient", sender: ProfilClient.client)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toUpdateClient"){
            let client = sender as! Client
            if let updateClientViewController = segue.destination as? UpdateClientViewController {
                updateClientViewController.client = client
            }

        }
    }
    
    @objc func reloadData(){
        imageUser.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + ProfilClient.client.image)!)
        imageUser.contentMode = .scaleAspectFill
        nomComplet.text = ProfilClient.client.nomComplet
        dateNaiss.text = String(ProfilClient.client.dateNaissance.prefix(10))
        lieuNaiss.text = ProfilClient.client.lieuNaissance
        cin_pass.text = ProfilClient.client.cin_pass
        dateEmiss.text = String(ProfilClient.client.dateEmission.prefix(10))
        profession.text = ProfilClient.client.proffession
        adresse.text = ProfilClient.client.adresse
        email.text = ProfilClient.client.mail
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
