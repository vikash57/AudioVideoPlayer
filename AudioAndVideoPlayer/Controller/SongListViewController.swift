//
//  SongListViewController.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 14/03/23.
//

import UIKit

class SongListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var arrOfData : ModelData?
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        registerCell()
        fetchData { data in
            self.arrOfData = data
            tblView.reloadData()
        }
    }
    
    func configureUI() {
        tblView.delegate = self
        tblView.dataSource = self
    }

    func registerCell() {
        tblView.register(UINib(nibName: "SongListTableViewCell", bundle: nil), forCellReuseIdentifier: "SongListTableViewCell")
    }
   

}
extension SongListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfData?.music.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "SongListTableViewCell") as! SongListTableViewCell
        if let data = arrOfData?.music[indexPath.row] {
            cell.configureData(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        var position = indexPath.row
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DescribtionListViewController") as? DescribtionListViewController else{return}
        if let data = self.arrOfData?.music {
            vc.arrOfDa = data
        }
        vc.position = position
        vc.select = false
        self.navigationController?.present(vc, animated: true)
    }
    
}
