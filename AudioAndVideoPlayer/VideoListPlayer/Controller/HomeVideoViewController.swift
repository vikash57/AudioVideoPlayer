//
//  HomeVideoViewController.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 20/03/23.
//

import UIKit

class HomeVideoViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tapges: UITapGestureRecognizer!

    var arrOfVideoData:VideoData?
    var tapGesture: UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        registerCell()
        fetchVideoData { data in
            self.arrOfVideoData = data
            tblView.reloadData()
        }
        
    }
    

    
    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func registerCell() {
        tblView.register(UINib(nibName: "VideoPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoPlayerTableViewCell")
    }

}
extension HomeVideoViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfVideoData?.videoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "VideoPlayerTableViewCell") as! VideoPlayerTableViewCell
        if let data = arrOfVideoData?.videoList[indexPath.row] {
            cell.playVideoPlayer(data.trackName)
            cell.titleLabel.text = data.titleName
            cell.describtionLabel.text = data.describtion
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        
        let vc1 = tblView.cellForRow(at: indexPath) as! VideoPlayerTableViewCell
        vc1.player?.pause()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoHomeViewController") as! VideoHomeViewController
        vc.sect = indexPath.row
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
//        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.present(vc, animated: true)
    }
    
}
