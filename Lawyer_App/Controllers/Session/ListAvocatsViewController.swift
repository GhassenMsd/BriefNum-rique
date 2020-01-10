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
    @IBOutlet var ta2kid: UIButton!
    
    var counts = 0

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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         
        if let cell = tableView.cellForRow(at: indexPath) {
            //cell.accessoryType = .none
            let label = cell.viewWithTag(0)?.viewWithTag(5) as! UILabel
            label.isHidden = true
            label.layer.cornerRadius = label.frame.size.width / 2
            label.layer.masksToBounds = true
            print(counts)
            counts -= 1
            label.text = "\(counts)"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            //cell.accessoryType = .checkmark

            let label = cell.viewWithTag(0)?.viewWithTag(5) as! UILabel
            label.isHidden = false
            label.layer.cornerRadius = label.frame.size.width / 2
            label.layer.masksToBounds = true
            print(counts)
            counts += 1
            label.text = "\(counts)"
        }
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        ta2kid.addShadowView()
        let avocatService = AvocatService()
        avocatService.getAvocatByDate(date: self.dateSession, idTribunal: self.idTrib){ (avocats) in
            self.avocatslist = avocats
            self.avocatTable.reloadWithAnimation()
        }
        
        
        self.avocatTable.allowsMultipleSelection = true
        self.avocatTable.allowsSelectionDuringEditing = true
        print(dateSession)
        print(idTrib)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Save(_ sender: Any) {
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

/*class CheckableTableViewCell: UITableViewCell {
    @IBOutlet var checkNumber: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        var increamentOrDecreamentValue = 0

            if (selected == true){
                checkNumber.isHidden = false
                print(increamentOrDecreamentValue)
                increamentOrDecreamentValue += 1;
                checkNumber.text = "\(increamentOrDecreamentValue)"
            }else if (selected == false){
                checkNumber.isHidden = true
            }
        
            
        
        checkNumber.layer.cornerRadius = checkNumber.frame.size.width / 2
        checkNumber.layer.masksToBounds = true
        //self.accessoryType = selected ? .checkmark : .none
    }
 }*/
