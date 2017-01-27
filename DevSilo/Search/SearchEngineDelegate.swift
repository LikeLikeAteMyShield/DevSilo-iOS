//
//  SearchEngineDelegate.swift
//  DevSilo
//
//  Created by Jonny Cameron on 25/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

protocol SearchEngineDelegate {
    func didCompleteSearch(result: ([Video],[ExternalVideo]))
}
