//
//  ExternalVideo.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class ExternalVideo {
    
    var uri: String
    var source: VideoSource
    var title: String
    var description: String
    var author: String
    var thumbnailLink: String
    
    init(uri:String, source:VideoSource, title:String, description:String, author:String, thumbnailLink:String) {
        self.uri = uri
        self.source = source
        self.title = title
        self.description = description
        self.author = author
        self.thumbnailLink = thumbnailLink
    }
}
