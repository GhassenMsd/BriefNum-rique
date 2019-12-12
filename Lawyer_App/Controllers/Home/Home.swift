//
//  Home.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/8/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

let months = ["يناير","فبراير","مارس","أبريل","مايو","يونيو","يوليو","أغسطس","سبتمبر","أكتوبر","نوفمبر","ديسمبر"]
let dayOfMonths = ["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dimanche"]
let dayInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]

var currentMonth = String()



var client5 = Client(name: "منذر الجريدي", mail: "Mondher@gmail.com", cin: 12345678,img: "5")
var client6 = Client(name: "خالد الراشد", mail: "Khaled@gmail.com", cin: 34562819,img: "3")
var client7 = Client(name: "منى الشادلي", mail: "Mouna@gmail.com", cin: 46590963,img: "4")
var client8 = Client(name: "خولة بن عمران", mail: "Khawla@gmail.com", cin: 00913267,img: "1")
var client9 = Client(name: "خولة بن عمران", mail: "Khawla@gmail.com", cin: 00913267,img: "1")

var listclient = [Client]()

class Home: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    

    @IBOutlet weak var numberClient: UILabel!
    @IBOutlet weak var numberCas: UILabel!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var UserList: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBAction func next(_ sender: Any) {
        switch currentMonth {
        case "ديسمبر":
            month = 0
            year += 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()

        default:
            month += 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
        switch currentMonth {
        case "يناير":
            month = 0
            year -= 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()

        default:
            month -= 1
            currentMonth = months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        View1.addShadowView()
        View2.addShadowView()
        View3.addShadowView()
        
        listclient.append(client5)
        listclient.append(client6)
        listclient.append(client7)
        listclient.append(client8)
        
        numberCas.layer.cornerRadius = numberCas.frame.size.width / 2
        numberClient.layer.cornerRadius = numberCas.frame.size.width / 2
        
        numberCas.layer.masksToBounds = true
        numberClient.layer.masksToBounds = true
        
        currentMonth = months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == Calendar){
            return dayInMonths[month]
        }
        return listclient.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == Calendar){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendar", for: indexPath)
            let contentView = cell.viewWithTag(10)
            let datelabel = contentView?.viewWithTag(11) as! UILabel
            
            cell.backgroundColor = UIColor.clear
            datelabel.text = "\(indexPath.row + 1)"
            return cell

        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let contentView = cell.viewWithTag(0)
        
        let name = contentView?.viewWithTag(2) as! UILabel
        let img = contentView?.viewWithTag(1) as! UIImageView
        name.text = listclient[indexPath.row].name
        img.image = UIImage(named: listclient[indexPath.row].img!)
        
        img.addShadowView()
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds = true

        return cell
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfil"{
            let cell = sender as! UICollectionViewCell
            let index = UserList.indexPath(for: cell)! as NSIndexPath
            if let profilViewController = segue.destination as? ProfilClient {
                //profilViewController.name = listclient[index.row].name
            
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "showProfil", sender: UserList.cellForItem(at: indexPath))
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
