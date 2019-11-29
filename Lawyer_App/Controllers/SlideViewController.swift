//
//  SlideViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 29/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!{
        didSet{
            titleText.numberOfLines = 0
        }
    }
    @IBOutlet weak var descriptionText: UILabel!{
        didSet{
            descriptionText.numberOfLines = 0
        }
    }
    
    var imaget = ""
    var subImaget = ""
    var titlet = ""
    var descriptiont = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = titlet
        descriptionText.text = descriptiont
        image.image = UIImage(named: imaget)
        subImage.image = UIImage(named: subImaget)

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
