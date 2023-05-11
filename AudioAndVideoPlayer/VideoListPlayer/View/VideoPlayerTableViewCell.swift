//
//  VideoPlayerTableViewCell.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 20/03/23.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerTableViewCell: UITableViewCell {


    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerView: UIView!
    
    
    let vcController = AVPlayerViewController()
    var player : AVPlayer?
    
    var didSlect : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //player?.pause()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func playVideoPlayer(_ resourse : String) {
        let path = Bundle.main.path(forResource: resourse, ofType: "mp4")
        
        let url = NSURL(fileURLWithPath: path!)
        
        player = AVPlayer(url: url as URL)
        
        
        vcController.player = player
            
        self.playerView.addSubview(vcController.view)
        vcController.view.frame.size.height = playerView.frame.size.height
        vcController.view.frame.size.width = playerView.frame.size.width
        //        controller.modalTransitionStyle = .crossDissolve
        //        controller.modalPresentationStyle = .overCurrentContext
        // Modally present the player and call the player's play() method when complete.
        //            present(vcController, animated: true) {
        //                player.play()
        //            }
        //player?.play()
        
    }
    
    func configureUI() {
        
    }
    
    
    
}
