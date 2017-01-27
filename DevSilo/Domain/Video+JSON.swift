//
//  Video+JSON.swift
//  DevSilo
//
//  Created by Jonny Cameron on 25/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

extension Video {

    convenience init?(json: [String:Any]) {
        guard let id = json["id"] as? [String:Int64],
            let idValue = id["value"],
            let title = json["title"] as? String
        else {
            return nil
        }
        
        do {
            let trusted_id = try Id(untrusted_id: idValue)
            self.init(id: trusted_id!, title: title)
        } catch {
            return nil
        }
    }
}
