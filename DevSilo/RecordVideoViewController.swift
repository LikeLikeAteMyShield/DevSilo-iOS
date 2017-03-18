//
//  RecordVideoViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 13/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        guard startCameraFromViewController(viewController: self, withDelegate: self) else {
            let alert = UIAlertController(title: "Error", message: "Cannot record at this time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func startCameraFromViewController(viewController: UIViewController, withDelegate delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        self.present(cameraController, animated: true, completion: nil)
        return true
    }

    func video(_ videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
        var title = "Great!"
        var message = "Your video has been saved to your device. Now just name it and upload it so others can find it!"
        
        if let _ = error {
            title = "Error"
            message = "Video failed to save"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(error) -> Void in
            self.performSegue(withIdentifier: "uploadSegue", sender: self) }))
        present(alert, animated: true, completion: nil)
    }
}

extension RecordVideoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismiss(animated: true, completion: nil)
        
        if mediaType == kUTTypeMovie {
            guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
            UploadingVideo.sharedInstance.setVideo(url: info[UIImagePickerControllerMediaURL] as! NSURL)
            
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(RecordVideoViewController.video(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
}

extension RecordVideoViewController: UINavigationControllerDelegate {
}

extension UIImagePickerController {
    override open var prefersStatusBarHidden: Bool {
        return true
    }
}

@IBDesignable
extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
