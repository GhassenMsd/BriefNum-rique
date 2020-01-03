//
//  ListAvocatsViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 1/2/20.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import UIKit



struct AvocatByDate{
var name: String
var affaire: Int

    init(name: String, affaire: Int)
    {
        self.name = name
        self.affaire = affaire
    }
}


class ListAvocatsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var avocatTable: UITableView!
    
    
    

    var avocatslist : Array<AvocatByDate> = []
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var dateSession = ""
    var idTrib = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avocatslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvocatCell")
        let contentView = cell?.viewWithTag(0)
        let view = contentView?.viewWithTag(1)

        let AvocatName = contentView?.viewWithTag(2) as! UILabel
        let Time = contentView?.viewWithTag(3) as! UILabel
        view!.addShadowView()

        AvocatName.text = avocatslist[indexPath.row].name
        Time.text = "قضية عدد " + String(avocatslist[indexPath.row].affaire)
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let avocatService = AvocatService()
        avocatService.getAvocatByDate(date: self.dateSession, idTribunal: self.idTrib){ (avocats) in
            self.avocatslist = avocats
            self.avocatTable.reloadData()
        }
        print(dateSession)
        print(idTrib)
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
