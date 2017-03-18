//
//  VideoContext.swift
//  DevSilo
//
//  Created by Jonny Cameron on 18/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class VideoContext {
    
    static let sharedInstance = VideoContext()
    
    private var currentVideo: Video?
    
    private init(){
    }
    
    func setCurrentVideo(video: Video) {
        self.currentVideo = video
    }
    
    func getCurrentVideo() -> Video? {
        return self.currentVideo
    }
}
