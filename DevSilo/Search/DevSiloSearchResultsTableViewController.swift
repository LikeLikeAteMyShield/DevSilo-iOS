//
//  DevSiloSearchResultsTableViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 28/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DevSiloSearchResultsTableViewController: UITableViewController {
    
    var videos: [Video]?
    var videoToPlay: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        videos = SearchResult.sharedInstance.getResult().0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (videos?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DevSiloCell", for: indexPath) as? DevSiloSearchResultTableViewCell

        let video = videos?[indexPath.row]
        cell?.titleLabel.text = video?.title
        
        let data = Data(base64Encoded: (video?.thumbnailData)!)
        let thumbnail = UIImage(data: data!)
        
        cell?.thumbnailImage.image = thumbnail
        
        return cell!
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AVPlayerViewController
        
        let indexPath = tableView.indexPathForSelectedRow
        let video = videos?[(indexPath?.row)!]
        
        let videoId = video?.id
        let url = URL(string: Constants.BASE_URL + "videos/\(videoId!.getValue())")
        
        if let videoURL = url {
            
            destinationVC.player = AVPlayer(url: videoURL)
            destinationVC.player?.play()
            destinationVC.updatesNowPlayingInfoCenter = true
            destinationVC.allowsPictureInPicturePlayback = true
        }
    }

}
