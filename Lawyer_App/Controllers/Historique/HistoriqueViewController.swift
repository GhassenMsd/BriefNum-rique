//
//  HistoriqueViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/3/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit


struct Jalaset{
var date: String
var affaire: String
var tribunal: String
var client: String
var sujet: String
var ahkem: String

    init(date: String, affaire: String,tribunal: String,client: String,sujet: String,ahkem: String)
    {
        self.date = date
        self.affaire = affaire
        self.tribunal = tribunal
        self.client = client
        self.sujet = sujet
        self.ahkem = ahkem
    }
}


class HistoriqueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableJalaset: UITableView!
    var jalasetList : Array<Jalaset> = []
    
    var jalsa1 = Jalaset(date: "01-02-2020", affaire: "143", tribunal: "محكمة تونس", client: "غسان مساعد", sujet: "لهرم القضائي يبررها في ذلك مبدأ النقض لمراقبة حسن تطبيق القوانين من طرف محاكم الأصل ولذلك فهي محكمة قانون وليست محكمة درجة ثالثة للقضاء بمعني أنها لا تنظر في الوقائع", ahkem: "نظرها علي الجانب القانوني للنزاع لمراقبة حسن تطبيق القانون من طرف محاكم الأصل وتتركب المحكمة من رئيس أول")
    
    var jalsa2 = Jalaset(date: "23-12-2020", affaire: "899", tribunal: "محكمة بن عروس", client: "عزيز حمادي", sujet: "تنظر محكمة التعقيب في الأحكام نهائية الدرجة، وذلك في خصوص سبع حالات أوردها الفصل 175 من مجلة المرافعات المدنية والتجارية، منها بالخصوص", ahkem: "تنظر محكمة التعقيب بدوائرها المجتمعة فيما يدعو إلى توحيد الآراء بين الدوائر وكذلك في الخطأ البيّن ")
    
    var SelectedIndex = -1
    var isCoollapse = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jalasetList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.SelectedIndex == indexPath.row && isCoollapse == true){
            return 526
        }else{
            return 95
        }
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
        
        dat.text = "جلسة " + jalasetList[indexPath.row].date
        aff.text = "قضية عدد " + jalasetList[indexPath.row].affaire
        trib.text = jalasetList[indexPath.row].tribunal
        clt.text = "الحريف: " + jalasetList[indexPath.row].client
        suj.text = jalasetList[indexPath.row].sujet
        ahk.text = jalasetList[indexPath.row].ahkem

        return cell!
    }
    
    @IBOutlet var maham: UIButton!
    @IBOutlet var jalaset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maham.addShadowView()
        jalaset.addShadowView()
        jalasetList.append(jalsa1)
        jalasetList.append(jalsa2)
        
        tableJalaset.estimatedRowHeight = 489
        tableJalaset.rowHeight = UITableViewAutomaticDimension
        tableJalaset.reloadWithAnimation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableJalaset.reloadWithAnimation()
    }
    
    @IBAction func MissionB(_ sender: Any) {
        maham.backgroundColor = UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0)
        maham.setTitleColor(.white, for: .normal)
        
        jalaset.backgroundColor = .white
        jalaset.setTitleColor(UIColor(red:0.00, green:0.23, blue:0.20, alpha:1.0), for: .normal)
    }
    
    @IBAction func SessionB(_ sender: Any) {
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
