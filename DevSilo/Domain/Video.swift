//
//  Video.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class Video {
    
    var id: Id!
    var title: String
    
    init(id: Id, title: String) {
        self.id = id
        self.title = title
    }
}
