//
//  UploadingVideo.swift
//  DevSilo
//
//  Created by Jonny Cameron on 17/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class UploadingVideo {
    
    static let sharedInstance = UploadingVideo()
    
    private var url: NSURL?
    
    private init() {
    }
    
    func setVideo(url: NSURL) {
        self.url = url
    }
    
    func getVideo() -> NSURL? {
        return self.url
    }
}
