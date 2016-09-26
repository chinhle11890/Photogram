//
//  ProfileViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPageViewControllerDataSource, HorizontalMenuDelegate {
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    
    @IBOutlet weak var collectionView: UIView!
    
    // MARK: - Constants
    let numberOfItem = 3
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
    
    @IBOutlet weak var containerMenuView: UIView!
    
    lazy var horizontalMenu: HorizontalMenu = {
        let menu = HorizontalMenu()
        menu.menuType = .PROFILE
        menu.delegate = self
        return menu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add horizontal menu
        containerMenuView.addSubview(horizontalMenu)
        containerMenuView.addConstraintsWithFormat("H:|[v0]|", views: horizontalMenu)
        containerMenuView.addConstraintsWithFormat("V:|[v0]|", views: horizontalMenu)
        
        // Set corner radius
        contactButton?.layer.cornerRadius = 10
        contactButton?.clipsToBounds = true
        contactButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        followingButton?.layer.cornerRadius = 10
        followingButton?.clipsToBounds = true
        
        createPageViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: Actions
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickEditProfileButton(_ sender: AnyObject) {

    }
    
    @IBAction func didClickMyEventsButton(_ sender: AnyObject) {
        slideToPage(index: 0, completion: nil)
    }
    
    @IBAction func didClickMyPhotosButton(_ sender: AnyObject) {
        slideToPage(index: 1, completion: nil)
    }
    
    @IBAction func didClickSavedPhotosButton(_ sender: AnyObject) {
        slideToPage(index: 2, completion: nil)
    }
    
    func slideToPage(index: Int, completion: (() -> Void)?) {
        if index >= numberOfItem || index < 0 {
            return
        }
        
        let currentViewController = pageViewController?.viewControllers![0] as! ProfilePageItemViewController
        let currentPageIndex = currentViewController.itemIndex
        
        print("\(index), \(currentPageIndex)")
        
        // Moving forward
        if index > currentPageIndex {
            if let vc: ProfilePageItemViewController = getItemController(index) {
                self.pageViewController!.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            }
        }
            // Moving backward
        else if index < currentPageIndex {
            if let vc: ProfilePageItemViewController = getItemController(index) {
                self.pageViewController!.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
            }        }
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
    
    // MARK: - HorizontalMenuDelegate
    func horizontalMenu(_ horizontalMenu: HorizontalMenu, didClickItemAt index: Int) {
        print("--->", index)
    }
}
