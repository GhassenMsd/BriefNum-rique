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
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var ViewSession: UIView!
    
    @IBOutlet var noteSession: UITextView!
    @IBOutlet var dateSession: UILabel!
    @IBOutlet var sujetSession: UITextView!
    @IBOutlet var Disp_prepSession: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = session.nomSession
        ViewSession.addShadowView()
        
        self.noteSession.text = session.notes
        self.dateSession.text = session.date
        self.sujetSession.text = session.sujet
        self.Disp_prepSession.text = session.Disp_prep
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
