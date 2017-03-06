//
//  SearchResult.swift
//  DevSilo
//
//  Created by Jonny Cameron on 28/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class SearchResult {
    
    static let sharedInstance = SearchResult()
    private var result : ([Video],[ExternalVideo])?
    
    private init() {
    }
    
    func getResult() -> ([Video],[ExternalVideo]) {
        return result!
    }
    
    func setResult(result: ([Video],[ExternalVideo])) {
        self.result = result
    }
}
