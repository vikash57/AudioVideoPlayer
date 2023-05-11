//
//  SongListTableViewCell.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 14/03/23.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    @IBOutlet weak var proView: UIView!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        containView.layer.cornerRadius = 10
        containView.layer.masksToBounds = true
        
        proView.layer.cornerRadius = 4
        proView.layer.masksToBounds = true
    }
    
    func configureData(_ data: Music) {
        imgView.image = UIImage(named: data.img as! String)
        titleName.text = data.titleName
        desLabel.text = data.describtion
    }
    
}
