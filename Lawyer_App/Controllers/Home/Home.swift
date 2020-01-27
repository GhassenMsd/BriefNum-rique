//
//  Home.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/8/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import FSCalendar
import QVRWeekView
import AlamofireImage
import Alamofire
import SDWebImage
import Floaty

extension Array{
    public mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
      newElements.forEach { (item) in
        if !(self.contains(where: { (selfItem) -> Bool in
            return !condition(selfItem, item)
        })) {
            self.append(item)
        }
    }
  }
}

class Home: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, WeekViewDelegate {
    
    
    //Outlet
    @IBOutlet weak var numberClient: UILabel!
    @IBOutlet weak var numberCas: UILabel!
    @IBOutlet weak var UserList: UICollectionView!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var rendezVouzLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var weekCalendar: WeekView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var weekView: UIView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calendarBtn: UIImageView!
    @IBOutlet weak var weekBtn: UIImageView!
    @IBOutlet var floaty: Floaty!
    @IBOutlet weak var hokm1: UILabel!
    @IBOutlet weak var iconHokm1: UIImageView!
    @IBOutlet weak var hokm2: UILabel!
    @IBOutlet weak var iconHokm2: UIImageView!
    @IBOutlet var toAhkemListe: UILabel!
    @IBOutlet var toClientListe: UILabel!
    
    //variables
    var allEvents: [Int: EventData] = [:]
    var eventsSortedByDay: [Date: [EventData]] = [:]
    var id: Int = 0     //id of event weekView
    static var clients: Array<Client> = []
    static var sessionByDate: Array<Session> = []
    var missions: Array<Mission> = []
    var rendezvousListe:Array<RendezVous> = []
    var sessions: Array<Session> = []
    var sessionsDate: Array<String> = []
    var missionsDate: Array<String> = []
    var rendezVousDate: Array<String> = []
    var sessionsDateTime: Array<Date> = []
    var missionsDateTime: Array<Date> = []
    var rendezVousListeDateTime: Array<Date> = []
    var sessionByDate: Array<Session> = []
    var missionByDate: Array<Mission> = []
    static var rendezVousByDate: Array<RendezVous> = []
    var alldateArray:Array<Date> = []
    let sessionService = SessionService()
    var ahkemListe: Array<Session> = []
    
    fileprivate let formatter = DateFormatter()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.addShadowView()
        view2.addShadowView()
        view3.addShadowView()
                
        numberCas.layer.cornerRadius = numberCas.frame.size.width / 2
        numberClient.layer.cornerRadius = numberCas.frame.size.width / 2
        
        numberCas.layer.masksToBounds = true
        numberClient.layer.masksToBounds = true
        
        
        let tapCalendar = UITapGestureRecognizer(target: self, action: #selector(tapCalendarBtn(_:)))
        calendarBtn.addGestureRecognizer(tapCalendar)
        let tapWeek = UITapGestureRecognizer(target: self, action: #selector(tapWeekBtn(_:)))
        weekBtn.addGestureRecognizer(tapWeek)

        let tapSession = UITapGestureRecognizer(target: self, action: #selector(tapSessionBtn))
        sessionLabel.addGestureRecognizer(tapSession)
        
        let tapMission = UITapGestureRecognizer(target: self, action: #selector(tapMissionBtn))
        missionLabel.addGestureRecognizer(tapMission)

        let tapRendezVous = UITapGestureRecognizer(target: self, action: #selector(tapRendezVousBtn))
        rendezVouzLabel.addGestureRecognizer(tapRendezVous)
        
        let tapSessionAhkem = UITapGestureRecognizer(target: self, action: #selector(tapAhkemNow))
        toAhkemListe.addGestureRecognizer(tapSessionAhkem)
        
        let tapClientListe = UITapGestureRecognizer(target: self, action: #selector(tapClients))
        toClientListe.addGestureRecognizer(tapClientListe)

        let tapHokm1G = UITapGestureRecognizer(target: self, action: #selector(tapHokm1))
        hokm1.addGestureRecognizer(tapHokm1G)
        
        let tapHokm2G = UITapGestureRecognizer(target: self, action: #selector(tapHokm2))
        hokm2.addGestureRecognizer(tapHokm2G)

        
        floaty.addItem("إضافة مهمة", icon: UIImage(named: "Groupe 584")!,handler: { _ in
            self.performSegue(withIdentifier: "toAddMission", sender: self)
        })
        floaty.addItem("إضافة موعد", icon: UIImage(named: "date_range-1")!,handler: { _ in
            self.performSegue(withIdentifier: "toAddRendezVous", sender: self)
        })
        floaty.addItem("إضافة حريف", icon: UIImage(named: "person")!,handler: { _ in
            self.performSegue(withIdentifier: "toAddClient", sender: self)
        })

        self.view.addSubview(floaty)
        
        initCalendarView()
        fetchClient()
        initWeekView()
        fetchRendezVous()
        fetchSession()
        fetchMission()
        fetchSessionByDate()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchClient), name: NSNotification.Name(rawValue: "fetchClient"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSessionByDate), name: NSNotification.Name(rawValue: "fetchSessionByDate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSession), name: NSNotification.Name(rawValue: "fetchSession"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchRendezVous), name: NSNotification.Name(rawValue: "fetchRendezVous"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchMission), name: NSNotification.Name(rawValue: "fetchMission"), object: nil)

    }
    
    func initCalendarView(){
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.calendar.appearance.titleFont = UIFont(name: "samim", size: 14)
        self.calendar.calendarHeaderView.calendar.locale = Locale(identifier: "ar_TN")
    }
    
    func initWeekView(){
        weekCalendar.zoomOffsetPreservation = .reset
        weekCalendar.delegate = self
        weekCalendar.mainBackgroundColor = .white
        weekCalendar.dayLabelDateLocaleIdentifier = "ar_TN"
        weekCalendar.dayViewMainSeparatorColor = .lightGray
        weekCalendar.topBarColor = .white
        weekCalendar.eventStyleCallback = { (layer, data) in
            layer.borderWidth = 0
            layer.cornerRadius = 0
        }
    }
    
    @objc func fetchClient(){
        let clientService = ClientService()
        clientService.getAll(){ (clients) in
            Home.clients = clients
            self.UserList.reloadData()
            self.numberClient.text = String(Home.clients.count)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchClients"), object: nil)
        }
    }
    
    @objc func fetchSessionByDate(){
        sessionService.getByDateNow(){ (sessions) in
            Home.sessionByDate = sessions
            self.ahkemListe = sessions.filter { (session) -> Bool in
                session.Disp_prep != ""
            }
            self.numberCas.text = String(self.ahkemListe.count)
            if self.ahkemListe.count > 0  {
                self.hokm1.text = self.ahkemListe[0].Disp_prep
                self.hokm1.isHidden = false
                self.iconHokm1.isHidden = false
                if self.ahkemListe.count > 1 {
                    self.hokm2.text = self.ahkemListe[1].Disp_prep
                    self.hokm2.isHidden = false
                    self.iconHokm2.isHidden = false
                }
            }
        }
    }
    
    @objc func tapHokm1(){
        print(11111111111)
        performSegue(withIdentifier: "toHokm", sender: 0)
    }
    
    @objc func tapHokm2(){
        print(0000000)
        performSegue(withIdentifier: "toHokm", sender: 1)
    }
    
    @objc func tapAhkemNow(){
        performSegue(withIdentifier: "toAhkemNow", sender: 1)
    }

    @objc func tapClients(){
        performSegue(withIdentifier: "toListeClient", sender: Home.clients)
    }
    
    @objc func tapSessionBtn(){
        performSegue(withIdentifier: "toSessionNow", sender: nil)
    }
    
    @objc func tapRendezVousBtn(){
        performSegue(withIdentifier: "toListeRendezVous", sender: nil)
    }
    
    @objc func tapMissionBtn(){
        performSegue(withIdentifier: "toListMissionDay", sender: nil)
    }
    
    @objc func fetchSession(){
        sessionService.getAll(){ (sessions) in
            self.sessionsDate = sessions.map({ (session) -> String in
                return String(session.date.prefix(10))
            })
            
            self.sessionsDateTime = sessions.map({ (session) -> Date in
                let date = self.dateFormatter1.date(from: session.date)!
                return date
            })
            
            self.alldateArray.appendDistinct(contentsOf: Array(Set(self.sessionsDateTime)), where: { (date1, date2) -> Bool in
                    let dateS1 = String(date1.description.prefix(10))
                    let dateS2 = String(date2.description.prefix(10))
                    return dateS1 != dateS2
            })
            //self.alldateArray.append(contentsOf: self.sessionsDateTime)
            self.sessions = sessions
            self.sessionByDate = sessions.filter { (session) -> Bool in
                session.date.contains(String(Date.init().description.prefix(10)))
            }
            self.sessionLabel.text = "الجلسات (" + String(self.sessionByDate.count) + ")"
            self.calendar.reloadData()
            self.weekCalendar.reloadData()
        }
    }
    
    @objc func fetchRendezVous(){
        let rendezVousService = RendezVousService()
        rendezVousService.getAll(){ (rendezvousArray) in
            self.rendezVousDate = rendezvousArray.map({ (rendezvous) -> String in
                return String(rendezvous.date.prefix(10))
            })
            self.rendezVousListeDateTime = rendezvousArray.map({ (rendezvous) -> Date in
                print(rendezvous.date)
                let date = self.dateFormatter1.date(from: rendezvous.date)!
                return date
            })
            self.alldateArray.appendDistinct(contentsOf: Array(Set(self.rendezVousListeDateTime)), where: { (date1, date2) -> Bool in
                    let dateS1 = String(date1.description.prefix(10))
                    let dateS2 = String(date2.description.prefix(10))
                    return dateS1 != dateS2
            })
            //self.alldateArray.append(contentsOf: self.rendezVousListeDateTime)

            self.rendezvousListe = rendezvousArray
            Home.rendezVousByDate = rendezvousArray.filter { (rendezVous) -> Bool in
                rendezVous.date.contains(String(Date.init().description.prefix(10)))
            }

            self.rendezVouzLabel.text = "المواعيد (" + String(Home.rendezVousByDate.count) + ")"
            self.calendar.reloadData()
            self.weekCalendar.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchRendezVousListe"), object: nil)
        }
        
    }
    
    @objc func fetchMission(){
        let missionService = MissionService()
        missionService.getAll(){ (missions) in
            self.missionsDate = missions.map({ (mission) -> String in
                return String(mission.date.prefix(10))
            })
            self.missionsDateTime = missions.map({ (mission) -> Date in
                print(self.dateFormatter1.date(from: mission.date)!)
                let date = self.dateFormatter1.date(from: mission.date)!
                return date
                })
            self.alldateArray.appendDistinct(contentsOf: Array(Set(self.missionsDateTime)), where: { (date1, date2) -> Bool in
                    let dateS1 = String(date1.description.prefix(10))
                    let dateS2 = String(date2.description.prefix(10))
                    return dateS1 != dateS2
            })
            //self.alldateArray.append(contentsOf: self.missionsDateTime)

            self.missions = missions
            self.missionByDate = missions.filter { (mission) -> Bool in
                mission.date.contains(String(Date.init().description.prefix(10)))
            }
            self.missionLabel.text = "المهام (" + String(self.missionByDate.count) + ")"

            self.calendar.reloadData()
            self.weekCalendar.reloadData()
        }

    }
    
    func didLongPressDayView(in weekView: WeekView, atDate date: Date) {
        
    }
    
    func didTapEvent(in weekView: WeekView, withId eventId: String) {
        
    }
    
    func eventLoadRequest(in weekView: WeekView, between startDate: Date, and endDate: Date) {
        
        let dates = DateSupport.getAllDates(between: startDate, and: endDate)
        for (date, events) in eventsSortedByDay where !dates.contains(date) {
            for event in events {
                allEvents[Int(event.id)!] = nil
            }
            eventsSortedByDay[date] = nil
        }

        for date in alldateArray where eventsSortedByDay[date] == nil {
            var dateEvents: [EventData] = []
            let startOfDate = date.getStartOfDay()
            let dateString = dateFormatter2.string(for: date)!
            let dateArraySession = self.sessions.filter{ String(($0).date).prefix(10) == dateString }
            let dateArrayMission = self.missions.filter{ String(($0).date).prefix(10) == dateString }
            let dateArrayRendezVous = self.rendezvousListe.filter{ String(($0).date).prefix(10) == dateString }
            for session in dateArraySession {
                let dateSession = self.dateFormatter1.date(from: session.date)!
                let hourDuration = 1.0
                let hourStart = dateSession.getTimeInHours() + 1
                let eventStartOffset = Int((hourStart)*60.0*60.0)
                let eventEndOffset = eventStartOffset+Int(hourDuration*60.0*60.0)

                let start = dateWithInterval(eventStartOffset, fromDate: startOfDate)
                let end = dateWithInterval(eventEndOffset, fromDate: startOfDate)

                let title = session.nomSession
                let color = UIColor(rgb: 0xBADFBE)

                let data = EventData(id: id, title: title, startDate: start, endDate: end, color: color)
                
                allEvents[id] = data
                
                dateEvents.append(data)
                id += 1
            }
            for mission in dateArrayMission {
                let dateMission = self.dateFormatter1.date(from: mission.date)!
                let hourDuration = 1.0
                let hourStart = dateMission.getTimeInHours() + 1
                let eventStartOffset = Int((hourStart)*60.0*60.0)
                let eventEndOffset = eventStartOffset+Int(hourDuration*60.0*60.0)

                let start = dateWithInterval(eventStartOffset, fromDate: startOfDate)
                let end = dateWithInterval(eventEndOffset, fromDate: startOfDate)

                let title = mission.nomMission
                let color = UIColor(rgb: 0xC3C8F2)

                let data = EventData(id: id, title: title, startDate: start, endDate: end, color: color)
                allEvents[id] = data
                dateEvents.append(data)
                id += 1
            }
            for rendezvous in dateArrayRendezVous {
                let dateRendezVous = self.dateFormatter1.date(from: rendezvous.date)!
                let hourDuration = 1.0
                let hourStart = dateRendezVous.getTimeInHours() + 1
                let eventStartOffset = Int((hourStart)*60.0*60.0)
                let eventEndOffset = eventStartOffset+Int(hourDuration*60.0*60.0)

                let start = dateWithInterval(eventStartOffset, fromDate: startOfDate)
                let end = dateWithInterval(eventEndOffset, fromDate: startOfDate)

                let title = rendezvous.nom
                let color = UIColor(rgb: 0xE6928D)

                let data = EventData(id: id, title: title, startDate: start, endDate: end, color: color)
                allEvents[id] = data
                dateEvents.append(data)
                id += 1
            }
            eventsSortedByDay[date] = dateEvents
        }
        weekView.loadEvents(withData: allEvents.isEmpty ? nil : Array(allEvents.values))
    }
    
    private func dateWithIntervalFromNow(_ interval: Int) -> Date {
        return Date(timeIntervalSinceNow: TimeInterval(exactly: interval)!)
    }

    private func dateWithInterval(_ interval: Int, fromDate date: Date) -> Date {
        return date.addingTimeInterval(TimeInterval(exactly: interval)! )
    }
    
    @objc func tapCalendarBtn(_ gesture:UITapGestureRecognizer) {
        calendarBtn.image = UIImage(named: "view_module")
        weekBtn.image = UIImage(named: "view_agenda")
        calendarView.isHidden = false
        weekView.isHidden = true
    }

    @objc func tapWeekBtn(_ gesture:UITapGestureRecognizer) {
        calendarBtn.image = UIImage(named: "view_module-1")
        weekBtn.image = UIImage(named: "view_agenda-1")
        calendarView.isHidden = true
        weekView.isHidden = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Home.clients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let contentView = cell.viewWithTag(0)
        
        let name = contentView?.viewWithTag(2) as! UILabel
        let img = contentView?.viewWithTag(1) as! UIImageView
        name.text = Home.clients[indexPath.row].nomComplet
        
        //img.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + Home.clients[indexPath.row].image)!)
        img.sd_imageIndicator = SDWebImageActivityIndicator.gray

        img.sd_setImage(with: URL(string: Connexion.adresse + "/Ressources/Client/" + Home.clients[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        
        img.contentMode = .scaleAspectFill
        img.addShadowImage(radius: (img.frame.size.width / 2))
        img.clipsToBounds = true

        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsClient"{
            let index = sender as! NSIndexPath
            if segue.destination is ProfilClient {
                ProfilClient.client = Home.clients[index.row]
            }
        }
        else if segue.identifier == "toListeClient"{
            if let listeClient = segue.destination as? ListClients{
                listeClient.clients = sender as! Array<Client>
            }
        }
        else if segue.identifier == "toSessionNow"{
            if let listSessionController = segue.destination as? SessionListeByDateViewController{
                listSessionController.sessionsList = self.sessionByDate
            }
        }
        else if segue.identifier == "toAhkemNow"{
            if let listSessionController = segue.destination as? SessionListeByDateViewController{
                listSessionController.sessionsList = self.ahkemListe
            }
        }
        else if segue.identifier == "toListMissionDay"{
            if let listMissionController = segue.destination as? MissionDayListViewController{
                listMissionController.missionsList = self.missionByDate
            }
        }
        else if segue.identifier == "toAddClient"{
            /*if let listMissionController = segue.destination as? MissionDayListViewController{
                listMissionController.missionsList = self.missionByDate
            }*/
        }
        else if segue.identifier == "toAddMission"{
            /*if let listMissionController = segue.destination as? MissionDayListViewController{
                listMissionController.missionsList = self.missionByDate
            }*/
        }
        else if segue.identifier == "toListeRendezVous"{
            /*if let listRendezVousController = segue.destination as? RendezVousListeViewController{
                listRendezVousController.rendezVousList = self.rendezVousByDate
            }*/
        }
        if segue.identifier == "toHokm"{
            let index = sender as! Int
            if let sessionDay = segue.destination as? SessionDayDetailViewController{
                sessionDay.session = self.ahkemListe[index]
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsClient", sender: indexPath)
    }
    
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        let tomorrow:Date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        print("aaaaaaaaaaaaaaa" + tomorrow.description)
        Home.rendezVousByDate = self.rendezvousListe.filter { (rendezVous) -> Bool in
            rendezVous.date.contains(String(tomorrow.description.prefix(10)))
        }

        self.rendezVouzLabel.text = "المواعيد (" + String(Home.rendezVousByDate.count) + ")"
        self.sessionByDate = self.sessions.filter { (session) -> Bool in
            session.date.contains(String(tomorrow.description.prefix(10)))
        }
        self.sessionLabel.text = "الجلسات (" + String(self.sessionByDate.count) + ")"
        
        self.missionByDate = self.missions.filter { (mission) -> Bool in
            mission.date.contains(String(tomorrow.description.prefix(10)))
        }
        self.missionLabel.text = "المهام (" + String(self.missionByDate.count) + ")"
        
    }
    
    @IBAction func monthPrec(_ sender: Any) {
        let currentdate = self.calendar.currentPage
        self.calendar.setCurrentPage(Calendar.current.date(byAdding: .month, value: -1, to: currentdate)!, animated: true)
    }
    
    @IBAction func mothSuiv(_ sender: Any) {
        let currentdate = self.calendar.currentPage
        self.calendar.setCurrentPage(Calendar.current.date(byAdding: .month, value: 1, to: currentdate)!, animated: true)
    }

    @IBAction func toListeClientAction(_ sender: Any) {
        performSegue(withIdentifier: "toListeClient", sender: Home.clients)
    }
    
    @IBAction func toAhkem(_ sender: Any) {
        performSegue(withIdentifier: "toAhkemNow", sender: nil)
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
