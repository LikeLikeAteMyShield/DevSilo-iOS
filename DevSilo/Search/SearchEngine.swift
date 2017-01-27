//
//  SearchEngine.swift
//  DevSilo
//
//  Created by Jonny Cameron on 25/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class SearchEngine {
    
    var delegate: SearchEngineDelegate
    
    init(delegate: SearchEngineDelegate) {
        self.delegate = delegate
    }
    
    func performSearch(searchPhrase:String) {
        
        var devsSiloVideos = [Video]()
        var externalVideos = [ExternalVideo]()
        
        let url = URL(string: Constants.BASE_URL + "search?searchPhrase=\(searchPhrase)")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let response = try! JSONSerialization.jsonObject(with: data, options: [])
            let json = response as? [String:Any]
            let devSiloVideosJson = json?["localVideos"] as? [[String:Any]]
            let externalVideosJson = json?["externalVideos"] as? [[String:Any]]
            
            for videoDict in devSiloVideosJson! {
                let video = Video(json: videoDict)
                if video != nil {
                    devsSiloVideos.append(video!)
                }
            }
            
            for externalVideoDict in externalVideosJson! {
                let video = ExternalVideo(json: externalVideoDict)
                if video != nil {
                    externalVideos.append(video!)
                }
            }
            
            self.delegate.didCompleteSearch(result: (devsSiloVideos,externalVideos))
        }
        
        task.resume()
    }
}
