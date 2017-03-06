//
//  Id.swift
//  DevSilo
//
//  Created by Jonny Cameron on 21/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class Id {
    
    private let value: Int64
    
    init?(untrusted_id : Int64) throws {
        if untrusted_id > 0 {
            self.value = untrusted_id
        } else {
            return nil
        }
    }
    
    public func getValue() -> Int64 {
        return value
    }
}
