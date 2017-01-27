//
//  VideoSource.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

enum VideoSource: String {
    case YouTube = "https://www.youtube.com/watch?v="
    case Vimeo = "https://vimeo.com/"
    case Dailymotion = "http://www.dailymotion.com/video/"
    
    static func valueFromString(string:String) -> VideoSource {
        if string == "YOUTUBE" {
            return VideoSource.YouTube
        } else if string == "VIMEO" {
            return VideoSource.Vimeo
        } else {
            return VideoSource.Dailymotion
        }
    }
}
