//
//  ObjectifUpdateViewController.swift
//  Lawyer_App
//
//  Created by Ghassen Msaad on 12/20/19.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class ObjectifUpdateViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var nomMission: UIView!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var JihaView: UIView!
    @IBOutlet weak var AdresseJihaView: UIView!
    @IBOutlet weak var TypeView: UIView!
    @IBOutlet weak var AmelView: UIView!
    @IBOutlet weak var NoteView: UIView!
    @IBOutlet var UpdateMission: UIButton!
    
    
    
    var mission = Mission()
    var missionUpdated = Mission()

    var datePicker = UIDatePicker()
    
    let missionServices = MissionService()

    override func viewDidLoad() {
        super.viewDidLoad()
        ShadowViews()
        PartieC.text = mission.partieConsernee
        Nom.text = mission.nomMission
        AdressePartieC.text = mission.adressePartieC
        DateObjectif.text = mission.date
        Notes.text = mission.notes
        typeMission.text = mission.type
        AAmel.text = mission.requis
        
        self.missionUpdated = Mission(id: self.mission.id, nomMission: self.Nom.text!, date: self.DateObjectif.text!, duree: "2 heures", partieConsernee: self.PartieC.text!, adressePartieC: self.AdressePartieC.text!, type: self.typeMission.text!, requis: self.AAmel.text!, notes: self.Notes.text!, id_Aff: self.mission.id_Aff)
        
        Notes.delegate = self
        datePicker.datePickerMode = .dateAndTime
        DateObjectif.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let tapDate = UITapGestureRecognizer(target: self, action: #selector(tapDateGuesture))
        self.view.addGestureRecognizer(tapDate)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapDateGuesture(){
        view.endEditing(true)
    }

    @objc func dateChanged(){
        getDateFromPicker()
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        DateObjectif.text = formatter.string(from: datePicker.date)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == mission.notes {
              textView.text = ""
              textView.textColor = UIColor(rgb: 0x003A33)
          }
      }
          
      func textViewDidEndEditing(_ textView: UITextView) {

          if textView.text == "" {

            textView.text = mission.notes
              textView.textColor = UIColor.lightGray
          }
      }
    
    @IBOutlet var PartieC: UITextField!
    @IBOutlet var Nom: UITextField!
    @IBOutlet var AdressePartieC: UITextField!
    @IBOutlet weak var DateObjectif: UITextField!
    @IBOutlet weak var Notes: UITextView!
    @IBOutlet var typeMission: UITextField!
    @IBOutlet var AAmel: UITextField!
    
    @IBAction func Update(_ sender: Any) {
        missionServices.UpdateMission(id: String(mission.id), nomMission: Nom.text!, date: DateObjectif.text!, duree: "2 heures", partieConcernee: PartieC.text!, adressePartieC: AdressePartieC.text!, type: typeMission.text!, requis: AAmel.text!, notes: Notes.text!){ () in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchDetailsMission"), object: nil)
            self.navigationController?.popViewController(animated: true)

        }

        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnDetailsM"{
            if let objectifDetailsViewController = segue.destination as? ObjectifDetailsViewController {
                objectifDetailsViewController.mission = self.missionUpdated
            }
        }
    }*/
    
    func ShadowViews() -> Void {
        DateView.addShadowView()
        JihaView.addShadowView()
        AdresseJihaView.addShadowView()
        TypeView.addShadowView()
        AmelView.addShadowView()
        NoteView.addShadowView()
        UpdateMission.addShadowView()
        nomMission.addShadowView()
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
