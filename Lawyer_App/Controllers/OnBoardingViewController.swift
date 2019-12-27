//
//  OnBoardingViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 28/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
        
    var slides:[Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlide()
        setupSlideScrollView(slides: slides)
        scrollView.delegate = self
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        print("ddddddddd")
    }
    
    func createSlide()-> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.image.image = UIImage(named: "Groupe 15")
        slide1.iconImage.image = UIImage(named: "Icon")
        slide1.titleText.text = "الجلسات"
        slide1.descriptionText.text = "ترتيب الجلسات و متابعتها و الحصول على تنبيهات بشأنها و تنسيقها بين المحامين كل ذلك صار متاحا مع 'الوجيز الرقمي'."

        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.image.image = UIImage(named: "Groupe 512")
        slide2.iconImage.image = UIImage(named: "Icon-1")
        slide2.titleText.text = "المواعيد"
        slide2.descriptionText.text = "استخدام المفكرة الورقية أو حتى الالكترونية صار أمرا من الماضي، متابعة المواعيد و التنبيه لها و تأخيرها أو تقديمها أو إلغاءها و تحديدها زمانيا و مكانيا هي المساعدة الرقمية التي يستحقها المحامي و يجدها بكل الفاعلية مع تطبيق 'الوجيز الرقمي'."

        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.image.image = UIImage(named: "Groupe 513")
        slide3.iconImage.image = UIImage(named: "Icon-2")
        slide3.titleText.text = "المهام"
        slide3.descriptionText.text = "'الوجيز الرقمي' يساعد المحامي على تنظيم المهام و الأحكام التحضيرية المزمع إنجازها و الجهات المكلفة بذلك و مواعيدها و آجالها و ربط ذلك آليا بالملفات أو الحرفاء أو الجلسات."
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
       
    }
    
    
    
    
}
