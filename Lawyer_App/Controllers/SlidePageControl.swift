//
//  SlidePageControl.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 28/11/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit

class SlidePageControl: UIPageViewController, UIPageViewControllerDataSource {
    
    var image = ["Groupe 515","Groupe 512","Groupe 513"]
    var subImage = ["Icon","Icon-1","Icon-2"]
    var titleText = ["تسجيل الدخول 3","تسجيل الدخول 2","تسجيل الدخول 1"]
    var descriptionText = ["أدخل بريدك الإلكتروني وسيرسل لك تعليمات حول كيفية إعادة تعيينه 3","أدخل بريدك الإلكتروني وسيرسل لك تعليمات حول كيفية إعادة تعيينه 2","أدخل بريدك الإلكتروني وسيرسل لك تعليمات حول كيفية إعادة تعيينه 1"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SlideViewController).index
        index -= 1
        return contentViewController(at: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         var index = (viewController as! SlideViewController).index
         index += 1
         return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> SlideViewController? {
        if index < 0 || index >= image.count {
            return nil
        }
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnBoarding") as? SlideViewController{
            pageContentViewController.imaget = image[index]
            pageContentViewController.subImaget = subImage[index]
            pageContentViewController.titlet = titleText[index]
            pageContentViewController.descriptiont = descriptionText[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
