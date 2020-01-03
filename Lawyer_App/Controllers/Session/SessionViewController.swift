//
//  SessionViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 03/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    var session = Session()
    var idSession = ""
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var ViewSession: UIView!
    
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var noteSession: UITextView!
    @IBOutlet var dateSession: UILabel!
    @IBOutlet var sujetSession: UITextView!
    @IBOutlet var Disp_prepSession: UITextView!
    
    @objc func fetchSessionDetail() -> Void {
        let sessionServices = SessionService()
        sessionServices.getSessionById(id: idSession){ (session) in
            
            self.navBar.title = "جلسة " + String(session.date.prefix(10))
            self.noteSession.text = session.notes
            self.dateSession.text = String(session.date.prefix(10))
            self.sujetSession.text = session.sujet
            self.Disp_prepSession.text = session.Disp_prep
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewSession.addShadowView()
        fetchSessionDetail()
        updateBtn.addShadowView()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSessionDetail), name: NSNotification.Name(rawValue: "fetchSessionDetail"), object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchJalsa"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchSession"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateSession"{
            if let updateSession = segue.destination as? SessionUpdateViewController {
                updateSession.session = self.session
            }
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
