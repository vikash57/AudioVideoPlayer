//
//  AdditinalViewController.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 16/03/23.
//

import UIKit
import AVFoundation
import AVFAudio
class AdditinalViewController: UIViewController , AVAudioPlayerDelegate{

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var arrOfSong:[AVPlayerItem] = []
    var arrOfData : ModelData?
    var queuePlayer: AVQueuePlayer!
    var playList : [AVPlayerItem] = []
    var timer: Timer?
    var stp = false
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData { data in
            self.arrOfData = data
            playSong()
            startTimer()
        }
    }
    
    func playSong() {
        guard let num = arrOfData?.music.count else {return}
        for i in 0...num-1 {
            var song1Url = Bundle.main.url(forResource: arrOfData?.music[i].trackName, withExtension: "mp3")!
            var song1Item = AVPlayerItem(url: song1Url)
            //arrOfSong[i] = song1Item
            arrOfSong.append(song1Item)
        }
        print(arrOfSong.count)

        let playlist = arrOfSong as! [AVPlayerItem]
        queuePlayer = AVQueuePlayer(items: playlist)
        slider.minimumValue = 0.00
         let duration = CMTimeGetSeconds(queuePlayer.currentItem!.duration)
        var dur: CMTime = queuePlayer.currentItem?.asset.duration ?? .zero
        var dur1: Float64 = CMTimeGetSeconds(dur)
        print("total time", dur1)
        slider.maximumValue = Float(dur1)
        
        let interval = CMTime(value: 1, timescale: 1)
        queuePlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let currentItem = self?.queuePlayer.currentItem else { return }
            let currentTimeSeconds = CMTimeGetSeconds(time)
            let durationSeconds = CMTimeGetSeconds(currentItem.duration)
            let progress = Float(currentTimeSeconds / durationSeconds)
            self?.slider.value = progress
            
        }
        
        
        playList = playlist
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: queuePlayer.currentItem)
        
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        if let currentItem = queuePlayer.currentItem, let index = playList.firstIndex(of: currentItem), index + 1 < playList.count {
            print("next Song")
            queuePlayer.advanceToNextItem()
            
        }
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(eventWith),
                                         userInfo: nil,
                                         repeats: true)
        }

        // Timer expects @objc selector
    @objc func eventWith() {
        if let ctm = queuePlayer.currentItem?.currentTime() {
            let currentTime = CMTimeGetSeconds(ctm)
                slider.value = Float(currentTime)
        }
        
        
        
    }
    
    
    
    
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
//        guard let currentItem = queuePlayer.currentItem else { return }
//            let durationSeconds = CMTimeGetSeconds(currentItem.duration)
//            let time = CMTime(seconds: Double(sender.value) * durationSeconds, preferredTimescale: 1)
//            queuePlayer.seek(to: time)
//        //queuePlayer.currentTime() = slider.value
        
    }
    
    
    
    

    
    @IBAction func playButtonAction(_ sender: Any) {
        queuePlayer.play()
        
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
        
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        queuePlayer.pause()
    }
    
    @IBAction func nextSongButtonAction(_ sender: Any) {
        queuePlayer.advanceToNextItem()
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        
    }
    
    
    
}
