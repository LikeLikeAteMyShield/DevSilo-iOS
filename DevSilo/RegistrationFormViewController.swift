//
//  RegistrationFormViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 03/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegistrationFormViewController: UIViewController, RegistrationEngineDelegate {

    @IBOutlet weak var userNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        userNameField.resignFirstResponder()
        
        if userNameField.text != "" && userNameField.text != nil {
            let centrePoint = CGPoint(x: self.view.frame.width/2-100, y: self.view.frame.height-250)
            let size = CGSize(width: 200, height: 200)
            let rect = CGRect(origin: centrePoint, size: size)
            
            let loadingIndicator = NVActivityIndicatorView(frame: rect, type: NVActivityIndicatorType.ballClipRotateMultiple, color: UIColor.init(colorLiteralRed: 102/255, green: 204/255, blue: 255/255, alpha: 1) , padding: NVActivityIndicatorView.DEFAULT_PADDING)
            self.view.addSubview(loadingIndicator)
            loadingIndicator.startAnimating()
            
            let engine = RegistrationEngine(delegate: self)
            engine.registerUserAccount(screenName: userNameField.text!)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a username", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func didRegisterUserAccount() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController()
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            UIApplication.shared.delegate?.window??.rootViewController = vc
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
