//
//  OtherSearchResultsTableViewController.swift
//  DevSilo
//
//  Created by Jonny Cameron on 28/01/2017.
//  Copyright © 2017 Jonny Cameron. All rights reserved.
//

import UIKit

class OtherSearchResultsTableViewController: UITableViewController {
    
    var videos : [ExternalVideo]?
    var thumbnails : [UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()

        videos = SearchResult.sharedInstance.getResult().1
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherResultCell", for: indexPath) as? OtherSearchResultTableViewCell

        let video = videos?[indexPath.row]
        cell?.titleLabel.text = video?.title
        cell?.authorLabel.text = video?.author
        cell?.sourceIcon.image = iconForVideoSource(source: (video?.source)!)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = NSData(contentsOf: URL(string: (video?.thumbnailLink)!)!)
            
            if let image = UIImage(data: data as! Data) {
                DispatchQueue.main.async {
                    cell?.thumbnailImage.image = image
                }
            }
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos?[indexPath.row]
        let urlString = (video?.source.rawValue)! + (video?.uri)!
        let url = URL(string: urlString)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func iconForVideoSource(source: VideoSource) -> UIImage {
        
        switch source {
        case .YouTube:
            return UIImage(named: "youtube-icon")!
        case .Vimeo:
            return UIImage(named: "vimeo-icon")!
        case .Dailymotion:
            return UIImage(named: "dailymotion-icon")!
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
