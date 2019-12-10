//
//  ListClients.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/10/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

var client1 = Client(name: "منذر الجريدي", mail: "Mondher@gmail.com", cin: 12345678,img: "5")
var client2 = Client(name: "خالد الراشد", mail: "Khaled@gmail.com", cin: 34562819,img: "3")
var client3 = Client(name: "منى الشادلي", mail: "Mouna@gmail.com", cin: 46590963,img: "4")
var client4 = Client(name: "خولة بن عمران", mail: "Khawla@gmail.com", cin: 00913267,img: "1")
var listc = [Client]()



class ListClients: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listc.count
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

        cin.text = String(listc[indexPath.row].cin)
        img.image = UIImage(named: listc[indexPath.row].img!)
        img.addShadowView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        mail.text = listc[indexPath.row].mail
        name.text = listc[indexPath.row].name
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        listc.append(client1)
        listc.append(client2)
        listc.append(client3)
        listc.append(client4)
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
