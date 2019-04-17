//
//  PageViewController.swift
//  SlideingScreens
//
//  Created by Mostafa Abd ElFatah on 4/17/19.
//  Copyright © 2019 Mostafa Abd ElFatah. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()
    
    lazy var slidingScreeens:[UIViewController] = {
        return [self.newVC(viewController: "vc1"),
                self.newVC(viewController: "vc2"),
                self.newVC(viewController: "vc3"),
                self.newVC(viewController: "vc4"),
                self.newVC(viewController: "vc5")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = slidingScreeens.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        configurePageControl()
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = slidingScreeens.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func newVC(viewController:String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
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

extension PageViewController:UIPageViewControllerDelegate {
    
    // MARK:- Page View Controller delegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = slidingScreeens.index(of: pageContentViewController)!
    }
    
   
    
    
    
}


extension PageViewController:UIPageViewControllerDataSource{
    
    
     // MARK:- Page View Controller DataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = slidingScreeens.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
             return slidingScreeens.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
           // return nil
        }
        
        guard slidingScreeens.count > previousIndex else {
            return nil
        }
        
        return slidingScreeens[previousIndex]
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = slidingScreeens.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard slidingScreeens.count != nextIndex else {
            return slidingScreeens.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard slidingScreeens.count > nextIndex else {
            return nil
        }
        
        return slidingScreeens[nextIndex]
    }
    
    
}
