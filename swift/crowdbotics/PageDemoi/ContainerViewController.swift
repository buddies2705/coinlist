//
//  ContainerViewController.swift
//  Jito
//
//  Created by Amit Kumar on 6/15/17.
//  Copyright © 2017 Amit Kumar. All rights reserved.
//

import UIKit

class ContainerViewController: UIPageViewController {

    weak var pageCustomDelegate: PageContainerCustomDelegates?
    var currentPageIndex : Int = 0
    
    
    fileprivate(set) lazy var setCurrentViewController: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newOnBoardViewController("ListTableViewController"),
                self.newOnBoardViewController("ListTableViewController"),
                self.newOnBoardViewController("ListTableViewController"),
                self.newOnBoardViewController("ListTableViewController"),]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        
         let initialViewController = setCurrentViewController[currentPageIndex]
            scrollToViewController(initialViewController)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 



/**
 Scrolls to the view controller at the given index. Automatically calculates
 the direction.
 
 - parameter newIndex: the new index to scroll to
 */
func scrollToViewController(index newIndex: Int) {
    if let firstViewController = viewControllers?.first,
        let currentIndex = setCurrentViewController.index(of: firstViewController) {
        let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
        let nextViewController = setCurrentViewController[newIndex]
        self.currentPageIndex = newIndex
        scrollToViewController(nextViewController, direction: direction)
    }
}

fileprivate func newOnBoardViewController(_ identifier: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: "\(identifier)")
}

/**
 Scrolls to the given 'viewController' page.
 - parameter viewController: the view controller to show.
 */

fileprivate func scrollToViewController(_ viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
    setViewControllers([viewController],
                       direction: direction,
                       animated: true,
                       completion: { (finished) -> Void in
                        
                        self.notifyTutorialDelegateOfNewIndex()
    })
}

/**
 Notifies '_tutorialDelegate' that the current page index was updated.
 */
fileprivate func notifyTutorialDelegateOfNewIndex() {
    
    if let firstViewController = viewControllers?.first,
        let index = setCurrentViewController.index(of: firstViewController) {
        pageCustomDelegate?.customPageViewController(self,
                                                   didUpdatePageIndex: index)
    }
}



}


// MARK: UIPageViewControllerDataSource

extension ContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = setCurrentViewController.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard setCurrentViewController.count > previousIndex else {
            return nil
        }
        
        return setCurrentViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = setCurrentViewController.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = setCurrentViewController.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return setCurrentViewController[nextIndex]
    }
    
}

extension ContainerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

protocol PageContainerCustomDelegates: class {
    
    
    func customPageViewController(_ onBaordPageViewController: ContainerViewController,
                                   didUpdatePageCount count: Int)
   
    
    
    func customPageViewController(_ onBaordViewController: ContainerViewController,
                                  didUpdatePageIndex index: Int)
   
    
    
}
