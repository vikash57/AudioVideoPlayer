//
//  DescribtionListViewController.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 14/03/23.
//

import UIKit
import AVFoundation

class DescribtionListViewController: UIViewController , AVAudioPlayerDelegate{

    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var repeatImgView: UIImageView!
    @IBOutlet weak var repeatView: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var autoPlayButton: UIButton!
    @IBOutlet weak var autoPlayLabel: UILabel!
    @IBOutlet weak var autoPlayImgView: UIImageView!
    @IBOutlet weak var autoPlayView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playImgView: UIImageView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var proView: UIView!
    
    var arrOfDa:[Music] = []
    var position = 0
    
    var select = true
    var player: AVAudioPlayer?
    var queuePlayer: AVQueuePlayer!
    var timer: Timer?
    var timer1: Timer?
    var autoPlay = false
    var repeatPlay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureUI()
        configureData(arrOfDa[position])
        playImgView.image = UIImage(named: "pauseButton")
        playSong(position)
        startTimer()
        slider.minimumValue = 0
        
        player?.delegate = self
       // player = try AVAudioPlayer(contentsOfURL: mp3URL)
        autoPlayImgView.image = UIImage(named: "switchOff")
    }
    
    func configureUI() {
        proView.layer.cornerRadius = 12
        proView.layer.masksToBounds = true
        
        slider.layer.cornerRadius = slider.bounds.height/2
        slider.layer.masksToBounds = true
        
        playView.layer.cornerRadius = playView.bounds.height/2
        playView.layer.masksToBounds = true
        
        autoPlayView.layer.cornerRadius = 12
        autoPlayView.layer.masksToBounds = true
        
        repeatView.layer.cornerRadius = 12
        repeatView.layer.masksToBounds = true
        
        nextView.layer.cornerRadius = nextView.bounds.height/2
        nextView.layer.masksToBounds = true
        
        previousView.layer.cornerRadius = previousView.bounds.height/2
        previousView.layer.masksToBounds = true
    }

    func configureData(_ data : Music) {
        imgView.image = UIImage(named: data.img as! String)
        titleLabel.text = data.titleName
        descLabel.text = data.describtion
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.stop()
    }
   
    @IBAction func playButtonAction(_ sender: Any) {
        
        if select == true {
            select = false
            player?.play()
            playImgView.image = UIImage(named: "pauseButton")
        }else {
            select = true
            player?.pause()
            playImgView.image = UIImage(named: "playButton")
        }
        
    }
    
    func playSong(_ posi: Int) {
        
        
        let urlString = Bundle.main.path(forResource: arrOfDa[posi].trackName, ofType: "mp3")

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("urlstring is nil")
                return
            }

            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            if let time = player?.duration {
                //slider.minimumValue = 0
                slider.maximumValue = Float(time)
            }
            guard let player = player else {
                print("player is nil")
                return
            }

            
            player.volume = 0.5
            player.play()
        }
        catch {
            print("error occurred")
        }
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
        if let val = player?.currentTime {
            slider.value = Float(val)
            
            if autoPlay == true {
                if slider.minimumValue == Float(player!.currentTime) {
                    autoPlayOn()
                }
            }else if repeatPlay == true {
                if slider.minimumValue == Float(player!.currentTime) {
                    player?.play()
                    playImgView.image = UIImage(named: "pauseButton")
                }
            }else {
                if slider.minimumValue == Float(player!.currentTime) {
                    //player?.play()
                    playImgView.image = UIImage(named: "playButton")
                }
            }
            
        }
        
        
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        player?.currentTime = TimeInterval(slider.value)
        
    }
    
//    func selector() {
//        if select == true {
//            select = false
//            player?.play()
//            playImgView.image = UIImage(named: "pauseButton")
//        }else {
//            select = true
//            player?.pause()
//            playImgView.image = UIImage(named: "playButton")
//        }
//    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if autoPlay == false, repeatPlay == false {
            playImgView.image = UIImage(named: "playButton")
        }

    }
    
    func autoPlayOn() {
        if position < arrOfDa.count-1 {
            position = position + 1
            configureData(arrOfDa[position])
            player?.numberOfLoops = -1
            playSong(position)
            playImgView.image = UIImage(named: "pauseButton")
            select = true
           
        } else {
            position = 0
            configureData(arrOfDa[position])
            playSong(position)
            playImgView.image = UIImage(named: "pauseButton")
            select = true
          
        }
        
    }
    
    
    @IBAction func autoPlayButtonAction(_ sender: Any) {
        if autoPlay == false {
            autoPlay = true
            repeatPlay = false
            autoPlayImgView.image = UIImage(named: "switchOn")
            repeatImgView.image = UIImage(named: "switchOff")
            repeatLabel.text = "Off"
            autoPlayLabel.text = "On"
        }else {
            autoPlay = false
            autoPlayImgView.image = UIImage(named: "switchOff")
            autoPlayLabel.text = "Off"
        }
    }
    

    @IBAction func nextButtonAction(_ sender: Any) {
        var ttl = arrOfDa.count-1
        if position < ttl {
            position = position + 1
            configureData(arrOfDa[position])
            playSong(position)
            playImgView.image = UIImage(named: "pauseButton")
            select = true
            
        }
    }
    
    
    @IBAction func previousButtonAction(_ sender: Any) {
        //var ttl = arrOfDa.count
        if position > 0 {
            position = position - 1
            configureData(arrOfDa[position])
            playSong(position)
            playImgView.image = UIImage(named: "pauseButton")
            select = true
           
        }
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
        if repeatPlay == false {
            repeatPlay = true
            autoPlay = false
            repeatImgView.image = UIImage(named: "switchOn")
            repeatLabel.text = "On"
            autoPlayImgView.image = UIImage(named: "switchOff")
            autoPlayLabel.text = "Off"
            
        } else {
            print("hello")
            repeatPlay = false
            repeatImgView.image = UIImage(named: "switchOff")
            repeatLabel.text = "Off"
        }
        
    }
    
    
    
    
}
extension DescribtionListViewController {
    
    func playSong1() {
        
    }
}
