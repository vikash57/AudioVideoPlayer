//
//  VideoListTableViewCell.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 20/03/23.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var proView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        proView.layer.cornerRadius = 4
        proView.layer.masksToBounds = true
    }
    
    func configureData(_ data: VideoList) {
        
        imgView.image = UIImage(named: data.img as! String)
        titleLabel.text = data.titleName
        descLabel.text = data.describtion
    }
    
}
