//
//  HistoriqueViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/3/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit

class HistoriqueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableJalaset: UITableView!
    @IBOutlet var tableMaham: UITableView!
    
    var jalasetListE : Array<SessionEnvoye> = []
    var mahamListE : Array<MissionEnvoye> = []
    var jalasetListR : Array<SessionRecu> = []
    var mahamListR : Array<MissionRecu> = []
    
    @IBOutlet var send: UIImageView!
    @IBOutlet var recieve: UIImageView!
    
    var SelectedIndex = -1
    var isCoollapse = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if(tableView == tableJalaset){
            if(self.send.image == UIImage(named: "call_made")){
                count = jalasetListE.count
            }else if (self.recieve.image == UIImage(named: "call_received (1)")){
                count = jalasetListR.count
            }

        }else {
            if(self.send.image == UIImage(named: "call_made")){
                count = mahamListE.count
            }else if (self.recieve.image == UIImage(named: "call_received (1)")){
                count = mahamListR.count
            }
            
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if(tableView == tableJalaset){
            if (self.SelectedIndex == indexPath.row && isCoollapse == true){
                
                height = 526
            }else{
                height = 95
            }
            
        }else if (tableView == tableMaham){
            if (self.SelectedIndex == indexPath.row && isCoollapse == true){

                height = 617
            }else{
                height = 95
            }
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(SelectedIndex == indexPath.row){
            if(self.isCoollapse == false){
                self.isCoollapse = true
            }else{
                self.isCoollapse = false
            }
        }else{
            self.isCoollapse = true
        }
        self.SelectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell() // Dummy value

        if (tableView == tableMaham){
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "mahamCell")
            let contentView = cell1?.viewWithTag(0)
            let view = contentView?.viewWithTag(10)
            let view2 = contentView?.viewWithTag(11)

            view!.addShadowView()
            view2!.addShadowView()

            
            let titre = contentView?.viewWithTag(1) as! UILabel
            let aff = contentView?.viewWithTag(2) as! UILabel
            let type = contentView?.viewWithTag(3) as! UILabel
            let jiha = contentView?.viewWithTag(4) as! UILabel
            let date = contentView?.viewWithTag(5) as! UITextView
            let adresseJiha = contentView?.viewWithTag(6) as! UITextView
            let note = contentView?.viewWithTag(7) as! UITextView
            let aamel = contentView?.viewWithTag(8) as! UILabel
            let tarafMoukabel = contentView?.viewWithTag(9) as! UILabel

            date.addShadowView()
            adresseJiha.addShadowView()
            note.addShadowView()
            
            if(self.send.image == UIImage(named: "call_made")){
                titre.text = mahamListE[indexPath.row].nomMission
                aff.text = "قضية عدد " + String(mahamListE[indexPath.row].numeroAffaire)
                type.text = mahamListE[indexPath.row].type
                jiha.text = mahamListE[indexPath.row].partieConcernee
                date.text = String(mahamListE[indexPath.row].dateMission.prefix(10))
                adresseJiha.text = mahamListE[indexPath.row].adressePartieC
                note.text = mahamListE[indexPath.row].notes
                aamel.text = mahamListE[indexPath.row].requis
                tarafMoukabel.text = mahamListE[indexPath.row].avocatMoukabel

            }else if (self.recieve.image == UIImage(named: "call_received (1)")){
                titre.text = mahamListR[indexPath.row].nomMission
                aff.text = "قضية عدد " + String(mahamListR[indexPath.row].numeroAffaire)
                type.text = mahamListR[indexPath.row].type
                jiha.text = mahamListR[indexPath.row].partieConcernee
                date.text = String(mahamListR[indexPath.row].dateMission.prefix(10))
                adresseJiha.text = mahamListR[indexPath.row].adressePartieC
                note.text = mahamListR[indexPath.row].notes
                aamel.text = mahamListR[indexPath.row].requis
                tarafMoukabel.text = mahamListR[indexPath.row].avocatMoukabel
            }
            cellToReturn = cell1!
            
        }else if (tableView == tableJalaset){
            let cell = tableView.dequeueReusableCell(withIdentifier: "jalasetCell")
            let contentView = cell?.viewWithTag(0)
            let view = contentView?.viewWithTag(7)
            let view2 = contentView?.viewWithTag(9)

            view!.addShadowView()
            view2!.addShadowView()

            
            let dat = contentView?.viewWithTag(1) as! UILabel
            let aff = contentView?.viewWithTag(2) as! UILabel
            let trib = contentView?.viewWithTag(3) as! UILabel
            let clt = contentView?.viewWithTag(4) as! UILabel
            let suj = contentView?.viewWithTag(5) as! UITextView
            let ahk = contentView?.viewWithTag(6) as! UITextView
            let taraf = contentView?.viewWithTag(10) as! UILabel
            
            suj.addShadowView()
            ahk.addShadowView()
            
            if(self.send.image == UIImage(named: "call_made")){
                dat.text = "جلسة " + jalasetListE[indexPath.row].dateSession.prefix(10)
                aff.text = "قضية عدد " + String(jalasetListE[indexPath.row].numeroAffaire)
                trib.text = jalasetListE[indexPath.row].tribunal
                clt.text = "الحريف: " + jalasetListE[indexPath.row].client
                suj.text = jalasetListE[indexPath.row].sujetSession
                ahk.text = jalasetListE[indexPath.row].Disp_prep
                taraf.text = jalasetListE[indexPath.row].avocatMoukabel
                
            }else if (self.recieve.image == UIImage(named: "call_received (1)")){
                dat.text = "جلسة " + jalasetListR[indexPath.row].dateSession.prefix(10)
                aff.text = "قضية عدد " + String(jalasetListR[indexPath.row].numeroAffaire)
                trib.text = jalasetListR[indexPath.row].tribunal
                clt.text = "الحريف: " + jalasetListR[indexPath.row].client
                suj.text = jalasetListR[indexPath.row].sujetSession
                ahk.text = jalasetListR[indexPath.row].Disp_prep
                taraf.text = jalasetListR[indexPath.row].avocatMoukabel
            }
            
            cellToReturn = cell!
        }
        
        return cellToReturn
    }
    
    @IBOutlet var maham: UIButton!
    @IBOutlet var jalaset: UIButton!
    
    
    func fetchSessionEnvoye() -> Void {
        let sessionService = SessionService()
        sessionService.getSessionsEnvoye(){ (sessions) in
            self.jalasetListE = sessions
            self.tableJalaset.reloadWithAnimation()
        }
    }
    
    func fetchMissionEnvoye() -> Void {
        let missionService = MissionService()
        missionService.getMissionsEnvoye(){ (missions) in
            self.mahamListE = missions
            self.tableMaham.reloadWithAnimation()
        }
    }
    
    func fetchSessionRecu() -> Void {
        let sessionService = SessionService()
        sessionService.getSessionsRecu(){ (sessions) in
            self.jalasetListR = sessions
            self.tableJalaset.reloadWithAnimation()
        }
    }
    
    func fetchMissionRecu() -> Void {
        let missionService = MissionService()
        missionService.getMissionsRecu(){ (missions) in
            self.mahamListR = missions
            self.tableMaham.reloadWithAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maham.addShadowView()
        jalaset.addShadowView()
        
        let tapRecu = UITapGestureRecognizer(target: self, action: #selector(tapRecus(_:)))
        recieve.addGestureRecognizer(tapRecu)
        recieve.isUserInteractionEnabled = true
        
        
        let tapEnv = UITapGestureRecognizer(target: self, action: #selector(tapEnvoye(_:)))
        send.addGestureRecognizer(tapEnv)
        send.isUserInteractionEnabled = true
        
        
        send.image = UIImage(named: "call_made")
        recieve.image = UIImage(named: "call_received")
        
        fetchMissionEnvoye()
        fetchSessionEnvoye()
        fetchMissionRecu()
        fetchSessionRecu()
        
        tableJalaset.estimatedRowHeight = 526
        tableJalaset.rowHeight = UITableViewAutomaticDimension
        tableJalaset.reloadWithAnimation()
        
        tableMaham.estimatedRowHeight = 617
        tableMaham.rowHeight = UITableViewAutomaticDimension
        tableMaham.reloadWithAnimation()
        
        
        
        maham.backgroundColor = UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0)
        maham.setTitleColor(.white, for: .normal)
        
        jalaset.backgroundColor = .white
        jalaset.setTitleColor(UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0), for: .normal)
        
        tableJalaset.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableMaham.reloadWithAnimation()
    }
    
    @objc func tapRecus(_ gesture:UITapGestureRecognizer) {
        recieve.image = UIImage(named: "call_received (1)")
        send.image = UIImage(named: "call_made (1)")
        tableMaham.reloadWithAnimation()
        tableJalaset.reloadWithAnimation()
    }
    
    
    @objc func tapEnvoye(_ gesture:UITapGestureRecognizer) {
        send.image = UIImage(named: "call_made")
        recieve.image = UIImage(named: "call_received")
        tableMaham.reloadWithAnimation()
        tableJalaset.reloadWithAnimation()
    }
    
    @IBAction func MissionB(_ sender: Any) {
        tableJalaset.isHidden = true
        tableMaham.isHidden = false
        tableMaham.reloadWithAnimation()
        
        maham.backgroundColor = UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0)
        maham.setTitleColor(.white, for: .normal)
        
        jalaset.backgroundColor = .white
        jalaset.setTitleColor(UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0), for: .normal)
    }
    
    @IBAction func SessionB(_ sender: Any) {
        tableMaham.isHidden = true
        tableJalaset.isHidden = false
        tableJalaset.reloadWithAnimation()

        jalaset.backgroundColor = UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0)
        jalaset.setTitleColor(.white, for: .normal)
        
        maham.backgroundColor = .white
        maham.setTitleColor(UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0), for: .normal)
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
