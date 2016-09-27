//
//  ProfileViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, HorizontalMenuDelegate {
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    
    @IBOutlet weak var collectionView: UIView!
    var pageIndex: Int = 0 {
        didSet {
            let selectedIndexPath = IndexPath(item: pageIndex, section: 0)
            horizontalMenu.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
            horizontalMenu.updateHorizontalBar(pageIndex)
        }
    }
    
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
    
    lazy var viewControllers: [UIViewController] = {
        var views = [UIViewController]()
        for i in 0..<3 {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePageItemViewController") as! ProfilePageItemViewController
            views.append(pageItemController)
        }
        return views
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add horizontal menu
        containerMenuView.addSubview(horizontalMenu)
        containerMenuView.addConstraintsWithFormat("H:|[v0]|", views: horizontalMenu)
        containerMenuView.addConstraintsWithFormat("V:|[v0]|", views: horizontalMenu)
        
        // Set corner radius
        contactButton?.layer.cornerRadius = 5
        contactButton?.clipsToBounds = true
        contactButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center;
        followingButton?.layer.cornerRadius = 5
        followingButton?.clipsToBounds = true
        
        createPageViewController()
    }
    
    fileprivate func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageController.dataSource = self
        pageController.delegate = self;
        
        let firstController = viewControllers.first
        let startingViewControllers = [firstController!]
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
    
    fileprivate func slideToPage(index: Int, completion: (() -> Void)?) {
        if index >= numberOfItem || index < 0 {
            return
        }
        
        let currentViewController = pageViewController?.viewControllers?.first
        let currentPageIndex = viewControllers.index(of: currentViewController!)
        
        // Moving forward
        if index > currentPageIndex! {
            self.pageViewController!.setViewControllers([viewControllers[index]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        } else if index < currentPageIndex! {
            self.pageViewController!.setViewControllers([viewControllers[index]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewControllers.index(of: viewController)
        if currentIndex! > 0 {
            return viewControllers[currentIndex! - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = viewControllers.index(of: viewController)
        if currentIndex! < viewControllers.count - 1 {
            return viewControllers[currentIndex! + 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = self.pageViewController?.viewControllers?.first, let index = viewControllers.index(of: firstViewController) {
            pageIndex = index
        }
    }

    // MARK: - HorizontalMenuDelegate
    func horizontalMenu(_ horizontalMenu: HorizontalMenu, didClickItemAt index: Int) {
        slideToPage(index: index, completion: nil)
    }
}
