//
//  VideoHomeViewController.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 18/03/23.
//

import UIKit
import AVFoundation
import AVKit
class VideoHomeViewController: UIViewController {

    @IBOutlet weak var autoPlayButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var playerView: UIView!
    
    
    let vcController = AVPlayerViewController()
    var player : AVPlayer?
    var timer : Timer!
    var arrOfVideoData:VideoData?
    var sect = 0
    var autoPlay = false
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        configureUI()
        fetchVideoData { data in
            self.arrOfVideoData = data
            if let raw = arrOfVideoData?.videoList[sect].trackName {
                playVideoPlayer(raw)
                startTimer()
            }
            tblView.reloadData()
        }
    }
    
    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
        
        autoPlayButton.layer.cornerRadius = 12
        autoPlayButton.layer.masksToBounds = true
        
    }
    
    func registerCell() {
        tblView.register(UINib(nibName: "VideoListTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoListTableViewCell")
    }
    
    func playVideoPlayer(_ resourse : String) {
        let path = Bundle.main.path(forResource: resourse, ofType: "mp4")
        let url = NSURL(fileURLWithPath: path!)
        player = AVPlayer(url: url as URL)
        
        vcController.player = player
        
        self.playerView.addSubview(vcController.view)
        vcController.view.frame.size.height = playerView.frame.size.height
        vcController.view.frame.size.width = playerView.frame.size.width
        
        player?.play()
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.30,
                                         target: self,
                                         selector: #selector(eventWith),
                                         userInfo: nil,
                                         repeats: true)
        }

        // Timer expects @objc selector
    @objc func eventWith() {
        if let val = player?.currentItem?.currentTime().seconds {
            let maxi = player?.currentItem?.duration.seconds
            var maxCount = arrOfVideoData?.videoList.count
            if autoPlay == true {
                if val == maxi {
                    if sect < maxCount ?? 0 {
                        sect = sect + 1
                        playVideoPlayer((arrOfVideoData?.videoList[sect].trackName)!)
                    }else {
                        sect = 0
                        playVideoPlayer((arrOfVideoData?.videoList[sect].trackName)!)
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func autoPlayButtonAction(_ sender: Any) {
        if autoPlay == false {
            autoPlay = true
            autoPlayButton.setTitle("Auto Play On", for: .normal)
            
        }else {
            autoPlay = false
            autoPlayButton.setTitle("Auto Play Off", for: .normal)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    
}

extension VideoHomeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfVideoData?.videoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell") as! VideoListTableViewCell
        if let data = arrOfVideoData?.videoList[indexPath.row] {
            cell.configureData(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player?.pause()
        
        var index = indexPath.row
       // var vc = tblView.cellForRow(at: <#T##IndexPath#>)
        //vc.containerView.backgroundColor = UIColor.yellow
        
        if let resource = arrOfVideoData?.videoList[index].trackName {
            sect = indexPath.row
            playVideoPlayer(resource)
            tblView.reloadData()
        }
    }
    
    
}
