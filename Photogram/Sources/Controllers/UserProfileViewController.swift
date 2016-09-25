//
//  UserProfileViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var collectionView: UIView!
    
    // MARK: - Constants
    let numberOfItem = 2
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
    }
    
    fileprivate func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageController.dataSource = self
        
        let firstController = getItemController(0)!
        let startingViewControllers = [firstController]
        pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        collectionView.addSubview(pageViewController!.view)
        let rect = CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        pageViewController!.view.frame = rect
        pageViewController!.didMove(toParentViewController: self)
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickEditProfileButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickMyPhotosButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func didClickSavedPhotosButton(_ sender: AnyObject) {
        
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ProfilePageItemViewController
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ProfilePageItemViewController
        if itemController.itemIndex+1 < numberOfItem {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    fileprivate func getItemController(_ itemIndex: Int) -> ProfilePageItemViewController? {
        
        if itemIndex < numberOfItem {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePageItemViewController") as! ProfilePageItemViewController
            pageItemController.itemIndex = itemIndex
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    func currentControllerIndex() -> Int {
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? ProfilePageItemViewController {
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
