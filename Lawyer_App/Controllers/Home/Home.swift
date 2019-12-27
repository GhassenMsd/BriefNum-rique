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
    
    //variables
    var allEvents: [Int: EventData] = [:]
    var eventsSortedByDay: [Date: [EventData]] = [:]
    var id: Int = 0     //id of event weekView
    static var clients: Array<Client> = []
    var missions: Array<Mission> = []
    var rendezvousListe:Array<RendezVous> = []
    var sessions: Array<Session> = []
    var sessionsDate: Array<String> = []
    var missionsDate: Array<String> = []
    var rendezVousDate: Array<String> = []
    var sessionsDateTime: Array<Date> = []
    var missionsDateTime: Array<Date> = []
    var rendezVousListeDateTime: Array<Date> = []
    
    
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

        initCalendarView()
        fetchClient()
        initWeekView()
        fetchRendezVous()
        fetchSession()
        fetchMission()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchClient), name: NSNotification.Name(rawValue: "fetchClient"), object: nil)

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

    
    func fetchSession(){
        let sessionService = SessionService()
        sessionService.getAll(){ (sessions) in
            self.sessionsDate = sessions.map({ (session) -> String in
                return String(session.date.prefix(10))
            })
            self.sessionsDateTime = sessions.map({ (session) -> Date in
                let date = self.dateFormatter1.date(from: session.date)!
                return date
            })
            self.sessions = sessions
            self.sessionLabel.text = "الجلسات (" + String(self.sessionsDate.count) + ")"
            self.calendar.reloadData()
            self.weekCalendar.reloadData()
        }
    }
    
    func fetchRendezVous(){
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
            self.rendezvousListe = rendezvousArray
            self.rendezVouzLabel.text = "المواعيد (" + String(self.rendezVousDate.count) + ")"
            self.calendar.reloadData()
            self.weekCalendar.reloadData()
        }
    }
    
    func fetchMission(){
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
            
            self.missions = missions
            self.missionLabel.text = "المهام (" + String(self.missionsDate.count) + ")"

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

        for date in sessionsDateTime where eventsSortedByDay[date] == nil {
            var dateEvents: [EventData] = []
            let startOfDate = date.getStartOfDay()
            let dateString = dateFormatter2.string(for: date)!
            let dateArraySession = self.sessions.filter{ String(($0).date).prefix(10) == dateString }
            let dateArrayMission = self.missions.filter{ String(($0).date).prefix(10) == dateString }
            let dateArrayRendezVous = self.rendezvousListe.filter{ String(($0).date).prefix(10) == dateString }
            for session in dateArraySession {
                let dateSession = self.dateFormatter1.date(from: session.date)!
                let hourDuration = 1.0
                let hourStart = dateSession.getTimeInHours()
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
                let hourStart = dateMission.getTimeInHours()
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
                let hourStart = dateRendezVous.getTimeInHours()
                let eventStartOffset = Int((hourStart)*60.0*60.0)
                let eventEndOffset = eventStartOffset+Int(hourDuration*60.0*60.0)

                let start = dateWithInterval(eventStartOffset, fromDate: startOfDate)
                let end = dateWithInterval(eventEndOffset, fromDate: startOfDate)

                let title = rendezvous.sujet
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
        img.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Client/" + Home.clients[indexPath.row].image)!)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
