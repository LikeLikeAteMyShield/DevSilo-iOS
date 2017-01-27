//
//  ViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SearchEngineDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func didCompleteSearch(result: ([Video],[ExternalVideo])) {
        DispatchQueue.main.async {
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
        let engine = SearchEngine(delegate: self)
        engine.performSearch(searchPhrase: searchBar.text!)
    }
}

