//
//  VideoDetailsViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 18/03/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoDetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var currentVideo: Video?

    override func viewDidLoad() {
        super.viewDidLoad()

        currentVideo = VideoContext.sharedInstance.getCurrentVideo()
        
        let data = Data(base64Encoded: (currentVideo?.thumbnailData)!)
        let thumbnail = UIImage(data: data!)
        thumbnailImageView.image = thumbnail
        
        titleLabel.text = currentVideo?.title
        authorLabel.text = currentVideo?.author
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "watchVideo" {
            let destinationVC = segue.destination as! AVPlayerViewController
        
            let videoId = currentVideo?.id
            let url = URL(string: Constants.BASE_URL + "videos/\(videoId!.getValue())")
        
            if let videoURL = url {
            
                destinationVC.player = AVPlayer(url: videoURL)
                destinationVC.player?.play()
                destinationVC.updatesNowPlayingInfoCenter = true
                destinationVC.allowsPictureInPicturePlayback = true
            }
        }
    }

}
