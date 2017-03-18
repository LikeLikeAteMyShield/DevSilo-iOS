//
//  UploadViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 17/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import AVFoundation

class UploadViewController: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailImageView.image = thumbnailForVideoAtURL(url: UploadingVideo.sharedInstance.getVideo()!)
    }
    
    private func thumbnailForVideoAtURL(url: NSURL) -> UIImage? {
        
        let asset = AVAsset(url: url as URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImageOrientation.right)
        } catch {
            print("error")
            return nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        
        if titleTextField.text != nil && titleTextField.text != "" {
            uploadVideoWithThumbnail()
        
            let alert = UIAlertController(title: "Thanks", message: "Your video will be uploaded shortly!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { Void in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a title for your video.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadVideoWithThumbnail() {
        
        if let url = URL(string:Constants.BASE_URL + "videos") {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            let metaJson = "{'title' : '\(self.titleTextField.text!)'}"
            
            request.addValue(UserDefaults.standard.string(forKey: "userId")!, forHTTPHeaderField: "user-id")
            request.addValue(metaJson, forHTTPHeaderField: "video-meta")
            
            request.setValue(NSString(format:"multipart/form-data; boundary=%@", Constants.BOUNDARY_IDENTIFIER) as String, forHTTPHeaderField: "Content-Type")
            
            let body = NSMutableData()
            
            body.append(NSString(format: "--%@\r\n", Constants.BOUNDARY_IDENTIFIER).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Disposition: form-data; name=\"file\"; filename=\"%@.mov\"\r\n", (self.titleTextField.text)!).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format:"Content-Type: video/quicktime\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            do {
                try body.append(NSData(contentsOf: UploadingVideo.sharedInstance.getVideo() as! URL) as Data)
            } catch {
                print("Error appending video data")
            }
            
            body.append(NSString(format:"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            
            body.append(NSString(format: "--%@\r\n", Constants.BOUNDARY_IDENTIFIER).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Disposition: form-data; name=\"thumbnail\"; filename=\"%@.jpg\"\r\n", (self.titleTextField.text)!).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format:"Content-Type: image/jpeg\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(UIImageJPEGRepresentation(thumbnailForVideoAtURL(url: UploadingVideo.sharedInstance.getVideo()!)!, 0.9)!)
            
            body.append(NSString(format:"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)

            body.append(NSString(format: "--%@--\r\n", Constants.BOUNDARY_IDENTIFIER).data(using: String.Encoding.utf8.rawValue)!)
            
            request.httpBody = body as Data
            
            let session = URLSession.shared

            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            })
            
            task.resume()
        }
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
