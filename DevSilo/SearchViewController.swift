//
//  ViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchViewController: UIViewController, SearchEngineDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var loadingIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func didCompleteSearch(result: ([Video],[ExternalVideo])) {
        DispatchQueue.main.async {
            SearchResult.sharedInstance.setResult(result: result)
            self.searchBar.isUserInteractionEnabled = true
            self.loadingIndicator?.stopAnimating()
            self.performSegue(withIdentifier: "ShowSearchResults", sender: self)
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
        
        loadingIndicator = NVActivityIndicatorView(frame: rect, type: NVActivityIndicatorType.ballClipRotateMultiple, color: UIColor.init(colorLiteralRed: 102/255, green: 204/255, blue: 255/255, alpha: 1) , padding: NVActivityIndicatorView.DEFAULT_PADDING)
        self.view.addSubview(self.loadingIndicator!)
        self.loadingIndicator?.startAnimating()
    }
}

