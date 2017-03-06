//
//  RegistrationEngine.swift
//  DevSilo
//
//  Created by Jonny Cameron on 03/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import Foundation

class RegistrationEngine {

    var delegate: RegistrationEngineDelegate
    
    init(delegate: RegistrationEngineDelegate) {
        self.delegate = delegate
    }
    
    func registerUserAccount(screenName: String) {
        
        var request = URLRequest(url: URL(string: Constants.BASE_URL + "users")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String:String] = ["screenName" : screenName]
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: body, options: [])
        } catch {}
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            let response = try! JSONSerialization.jsonObject(with: data, options: [])
            let json = response as? [String:Any]
            let userId = json?["createdUserId"] as! String
            
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(screenName, forKey: "screenName")
            
            self.delegate.didRegisterUserAccount()
        }
        task.resume()
    }
}
