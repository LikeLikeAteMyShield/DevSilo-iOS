//
//  SearchResultsRootViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 27/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit

class SearchResultsRootViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        
        //Initially load the recent searches view
        /*
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecentSearchesTable")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.containerView)
        */
        super.viewDidLoad()
    }
    
    /*func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showComponent(sender: UISegmentedControl) {
        
        //Show searches or routes based on user selection
        
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecentSearchesTable")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        } else if sender.selectedSegmentIndex == 1 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "PreviousRoutesTable")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }
    }
    
    //Animate the transition from one view to another
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMove(toParentViewController: self)
        })
    }*/

}
