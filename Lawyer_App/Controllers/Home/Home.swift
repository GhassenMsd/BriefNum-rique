//
//  Home.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/8/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import FSCalendar


var client5 = Client(name: "منذر الجريدي", mail: "Mondher@gmail.com", cin: 12345678,img: "5")
var client6 = Client(name: "خالد الراشد", mail: "Khaled@gmail.com", cin: 34562819,img: "3")
var client7 = Client(name: "منى الشادلي", mail: "Mouna@gmail.com", cin: 46590963,img: "4")
var client8 = Client(name: "خولة بن عمران", mail: "Khawla@gmail.com", cin: 00913267,img: "1")
var client9 = Client(name: "خولة بن عمران", mail: "Khawla@gmail.com", cin: 00913267,img: "1")

var listclient = [Client]()

class Home: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    

    @IBOutlet weak var numberClient: UILabel!
    @IBOutlet weak var numberCas: UILabel!
    @IBOutlet weak var UserList: UICollectionView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var rendezVouzLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.addShadowView()
        view2.addShadowView()
        view3.addShadowView()
        
        listclient.append(client5)
        listclient.append(client6)
        listclient.append(client7)
        listclient.append(client8)
        
        numberCas.layer.cornerRadius = numberCas.frame.size.width / 2
        numberClient.layer.cornerRadius = numberCas.frame.size.width / 2
        
        numberCas.layer.masksToBounds = true
        numberClient.layer.masksToBounds = true
        
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.calendar.appearance.titleFont = UIFont(name: "samim", size: 14)
        self.calendar.calendarHeaderView.calendar.locale = Locale(identifier: "ar_TN")
        
        let sessionService = SessionService()
        let missionService = MissionService()
        let rendezVousService = RendezVousService()
        sessionService.getAll(){ (sessions) in
            self.sessionsDate = sessions.map({ (session) -> String in
                return session.date
            })
            self.sessionLabel.text = "الجلسات (" + String(self.sessionsDate.count) + ")"
            self.calendar.reloadData()
        }
        missionService.getAll(){ (missions) in
            print(missions)
            self.missionsDate = missions.map({ (mission) -> String in
                return mission.date
            })
            self.missionLabel.text = "المهام (" + String(self.missionsDate.count) + ")"
            self.calendar.reloadData()
        }
        rendezVousService.getAll(){ (rendezvousArray) in
            print(rendezvousArray)
            self.rendezVousDate = rendezvousArray.map({ (rendezvous) -> String in
                return rendezvous.date
            })
            self.rendezVouzLabel.text = "المواعيد (" + String(self.rendezVousDate.count) + ")"

            self.calendar.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listclient.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
                profilViewController.name = listclient[index.row].name!
            
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProfil", sender: UserList.cellForItem(at: indexPath))
    }
    

    var sessionsDate: Array<String> = []
    var missionsDate: Array<String> = []
    var rendezVousDate: Array<String> = []
    fileprivate let formatter = DateFormatter()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
       
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        var i = 0
        if self.sessionsDate.contains(dateString) {
            i += 1
        }
        if self.missionsDate.contains(dateString) {
            i += 1
        }
        if self.rendezVousDate.contains(dateString) {
            i += 1
        }
        return i
    }
        
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        var arrayColor:Array<UIColor> = []
        let dateString = self.dateFormatter2.string(from: date)
        appearance.eventOffset = CGPoint(x: 0 , y: -10)
        
        if self.sessionsDate.contains(dateString) {
            arrayColor.append(UIColor(rgb: 0x307C62))
        }
        if self.missionsDate.contains(dateString) {
            arrayColor.append(UIColor(rgb: 0x5B86F2))
        }
        if self.rendezVousDate.contains(dateString) {
            arrayColor.append(UIColor(rgb: 0xE6928D))
        }
        return arrayColor
    }
    
    @IBAction func monthPrec(_ sender: Any) {
        let currentdate = self.calendar.currentPage
        self.calendar.setCurrentPage(Calendar.current.date(byAdding: .month, value: -1, to: currentdate)!, animated: true)
    }
    
    @IBAction func mothSuiv(_ sender: Any) {
        let currentdate = self.calendar.currentPage
        self.calendar.setCurrentPage(Calendar.current.date(byAdding: .month, value: 1, to: currentdate)!, animated: true)
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
