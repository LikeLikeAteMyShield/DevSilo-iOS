//
//  ExternalVideo+JSON.swift
//  DevSilo
//
//  Created by Jonny Cameron on 25/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

extension ExternalVideo {
    
    convenience init?(json: [String:Any]) {
        guard let uri = json["uri"] as? String,
            let source = json["source"] as? String,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let author = json["author"] as? String,
            let thumbnailLink = json["thumbnailLink"] as? String
        else {
            return nil
        }
        
        self.init(uri: uri, source: VideoSource.valueFromString(string: source), title: title, description: description, author: author, thumbnailLink: thumbnailLink)
    }
}
