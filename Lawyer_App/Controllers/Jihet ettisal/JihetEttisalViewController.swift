//
//  JihetEttisalViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 13/01/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit
import iOSDropDown

class MyTapGesture: UITapGestureRecognizer {
    var tel = ""
}


class JihetEttisalViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var jihetEttisalView: UIView!
    @IBOutlet weak var rechercheView: UIView!
    @IBOutlet weak var specialiteView: UIView!
    @IBOutlet weak var jihetEttisal: DropDown!
    @IBOutlet weak var specialite: DropDown!
    @IBOutlet weak var recherche: UITextField!
    var selectedjihetEttisal = ""
    var selectedSpecialite = ""
    var type = ""
    let jihetEttisalService = JihetEttisalService()
    var jihetListe:Array<JihetEttisal> = []
    var filterListe:Array<JihetEttisal> = []
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var listespecialiteExpert = ["خبير عدلي","طب شرعي","طب تقدير الضرر البدني","مؤتمن عدلي","مصفي","أمناء الفلسة","المتصرفون القضائيون"]
    
    var listeJihatEttisal = ["مترجم محلف","عدل منفذ","عدل اشهاد","خبير"]
    
    var listeSpecialite = ["تونس","تونس 2","أريانة","بن عروس","منوبة","بنزرت","باجة","قرمبالية","نابل","زغوان","الكاف","جندوبة","سليانة","القصرين","سوسة","سوسة 2","القيروان","المنستير","المھدية","صفاقس","صفاقس 2","قفصة","توزر","سيدي بوزيد","قابس","قبلي","مدنين","تطاوين"]
    
    var listeSpecialiteMotarjem = ["الفرنسية","الأنجليزية","الالمانية","الإيطالية","الإسبانية","السويدية","الروسية","الصينية","العربية","لغة الاشارات"]
    
    var hidenJihetEttisal = true
    var hidenSpecialite = true

    override func viewDidLoad() {
        super.viewDidLoad()
        jihetEttisalView.addShadowView()
        specialiteView.addShadowView()
        rechercheView.addShadowView()
        
        self.jihetEttisal.optionArray = listeJihatEttisal
            
        jihetEttisal.didSelect{(selectedText , index ,id) in
            self.hidenJihetEttisal = true
            print(index)
            if index == 0 {
                self.selectedjihetEttisal = "traducteur"
                self.type = "specialite"
                self.specialite.optionArray = self.listeSpecialiteMotarjem
            }
            else if index == 3{
                self.selectedjihetEttisal = "expert"
                self.type = "specialite"
                self.specialite.optionArray = self.listespecialiteExpert
            }
            else{
                self.type = "tribunal"
                self.selectedjihetEttisal = "huissiernotaire"
                if index == 2{
                    self.selectedjihetEttisal = "huissierdejustice"
                }
                self.specialite.optionArray = self.listeSpecialite
            }
            self.specialite.text = ""
            self.specialite.selectedIndex = nil
            self.jihetListe = []
            self.filterListe = []
            self.resultTableView.reloadData()
            
            //self.idTribunal = self.list[index].id
            //print("idTribunal " + String(self.idTribunal))
            
            //self.fetchCercle(id: String(self.list[index].id))
        }
        
        jihetEttisal.listWillAppear {
            self.hidenJihetEttisal = false
        }
        jihetEttisal.listWillDisappear {
            self.hidenJihetEttisal = true
        }
        
        specialite.didSelect{(selectedText , index ,id) in
            self.hidenSpecialite = true
            self.selectedSpecialite = selectedText
            self.jihetEttisalService.getAll(table: self.selectedjihetEttisal, type: self.type, specialite: self.selectedSpecialite){ (response) in
                self.jihetListe = response
                self.filterListe = self.jihetListe
                self.resultTableView.reloadWithAnimation()
            }
            //self.idTribunal = self.list[index].id
            //print("idTribunal " + String(self.idTribunal))
            
            //self.fetchCercle(id: String(self.list[index].id))
        }
        
        specialite.listWillAppear {
            self.hidenSpecialite = false
        }
        specialite.listWillDisappear {
            self.hidenSpecialite = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ToggleJiha(_ sender: Any) {
        if(hidenJihetEttisal){
            jihetEttisal.showList()
        }
        else{
            jihetEttisal.hideList()
        }
    }
    
    @IBAction func ToggleSpecialite(_ sender: Any) {
        if(hidenSpecialite){
            specialite.showList()
        }
        else{
            specialite.hideList()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultatCell")
        let contentView = cell?.viewWithTag(0)
        
        let nom = contentView?.viewWithTag(5) as! UILabel
        let adresse = contentView?.viewWithTag(6) as! UILabel
        let tel = contentView?.viewWithTag(7) as! UILabel
        let tel2 = contentView?.viewWithTag(8) as! UILabel
        let tel3 = contentView?.viewWithTag(9) as! UILabel
        let view = contentView?.viewWithTag(1)!

        var telString = "ليس لديه"
        var tel2String = ""
        var tel3String = ""
        if(self.filterListe[indexPath.row].tel != ""){
            telString = self.filterListe[indexPath.row].tel
        }
        if(self.filterListe[indexPath.row].tel2 != ""){
            tel2String = self.filterListe[indexPath.row].tel2
        }
        if(self.filterListe[indexPath.row].tel3 != ""){
            tel3String = self.filterListe[indexPath.row].tel3
        }
        
        view!.addShadowView()

        nom.text = self.filterListe[indexPath.row].nomComplet
        adresse.text = self.filterListe[indexPath.row].adresse
        tel.text = telString
        tel2.text = tel2String
        tel3.text = tel3String
        
        
        let tappedtel = MyTapGesture.init(target: self, action: #selector(makePhoneCall))
        tappedtel.tel = telString
        tappedtel.numberOfTapsRequired = 1
        tel.addGestureRecognizer(tappedtel)
        
        let tappedtel2 = MyTapGesture.init(target: self, action: #selector(makePhoneCall))
        tappedtel2.tel = tel2String
        tappedtel2.numberOfTapsRequired = 1
        tel2.addGestureRecognizer(tappedtel2)
        
        let tappedtel3 = MyTapGesture.init(target: self, action: #selector(makePhoneCall))
        tappedtel3.tel = tel3String
        tappedtel3.numberOfTapsRequired = 1
        tel3.addGestureRecognizer(tappedtel3)
        
        return cell!
    }
    
    @IBAction func searchChangeAction(_ sender: Any) {
        print(self.recherche.text!)
        if(self.recherche.text! != ""){
            self.filterListe = self.jihetListe.filter { (jihetEttisal) -> Bool in
                jihetEttisal.nomComplet.uppercased().contains(self.recherche.text!.uppercased()) || jihetEttisal.adresse.uppercased().contains(self.recherche.text!.uppercased()) || jihetEttisal.tel.uppercased().contains(self.recherche.text!.uppercased()) || jihetEttisal.cercle.uppercased().contains(self.recherche.text!.uppercased()) || jihetEttisal.tel2.uppercased().contains(self.recherche.text!.uppercased()) || jihetEttisal.tel3.uppercased().contains(self.recherche.text!.uppercased())
            }
        }
        else{
            self.filterListe = self.jihetListe
        }
        self.resultTableView.reloadData()
    }
    
    @objc func makePhoneCall(recognizer: MyTapGesture) {
        print("aaaaaaaa " + recognizer.tel)
        if let phoneURL = URL(string: ("tel://" + recognizer.tel)) {

            let alert = UIAlertController(title: ("هل تريد الاتصال ب " + recognizer.tel + " ?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { (action) in
                //
                UIApplication.shared.openURL(phoneURL as URL)
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))

            alert.addAction(UIAlertAction(title: "لا", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
