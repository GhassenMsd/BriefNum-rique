//
//  testViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 14/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import FSCalendar

class testViewController: UIViewController , FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
        let sessionService = SessionService()
        sessionService.getAll(){ (sessions) in
            print(sessions)
            self.sessionsDate = sessions.map({ (session) -> String in
                return session.date
            })
            self.calendar.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    var sessionsDate: Array<String> = []
    
    @IBOutlet weak var calendar: FSCalendar!
    
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
        
        return i
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        var arrayColor:Array<UIColor> = []
        let dateString = self.dateFormatter2.string(from: date)
        if self.sessionsDate.contains(dateString) {
            arrayColor.append(UIColor.magenta)
        }
        return arrayColor
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
