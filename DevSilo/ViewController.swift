//
//  ViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController, SearchEngineDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var loadingIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func didCompleteSearch(result: ([Video],[ExternalVideo])) {
        DispatchQueue.main.async {
            self.searchBar.isUserInteractionEnabled = true
            self.loadingIndicator?.stopAnimating()
            self.performSegue(withIdentifier: "ShowSearchResults", sender: self)
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.isUserInteractionEnabled = false
        let engine = SearchEngine(delegate: self)
        engine.performSearch(searchPhrase: searchBar.text!)
        let centrePoint = CGPoint(x: self.view.frame.width/2-150, y: self.view.frame.height/2-100)
        let size = CGSize(width: 300, height: 300)
        let rect = CGRect(origin: centrePoint, size: size)
        loadingIndicator = NVActivityIndicatorView(frame: rect, type: NVActivityIndicatorType.ballClipRotatePulse, color: UIColor.orange, padding: NVActivityIndicatorView.DEFAULT_PADDING)
        self.view.addSubview(self.loadingIndicator!)
        self.loadingIndicator?.startAnimating()
    }
}

