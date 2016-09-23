//
//  TutorialViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/22/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet weak var pageControl: UIPageControl?
    @IBOutlet weak var skipButton: UIButton?
    
    // MARK: - Constants
    let numberOfItem = 5
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func skipButtonAction(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC : SignInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(signInVC, animated: true, completion: nil)
    }
    
    fileprivate func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageController.dataSource = self
        
        let firstController = getItemController(0)!
        let startingViewControllers = [firstController]
        pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
        
        // Bring pageControl and skip button to front
        self.view.bringSubview(toFront: pageControl!)
        self.view.bringSubview(toFront: skipButton!)
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.clear
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemViewController
        pageControl?.currentPage = itemController.itemIndex
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemViewController
        pageControl?.currentPage = itemController.itemIndex
        if itemController.itemIndex+1 < numberOfItem {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    fileprivate func getItemController(_ itemIndex: Int) -> PageItemViewController? {
        
        if itemIndex < numberOfItem {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "PageItemViewController") as! PageItemViewController
            pageItemController.itemIndex = itemIndex
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageControl?.numberOfPages = numberOfItem
        
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    func currentControllerIndex() -> Int {
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemViewController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        if (self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
}
