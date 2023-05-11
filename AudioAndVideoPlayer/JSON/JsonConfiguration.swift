//
//  JsonConfiguration.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 14/03/23.
//

import Foundation

func fetchData(completionHandler: (ModelData) -> Void){
    guard let fileLocation = Bundle.main.url(forResource: "modalData", withExtension: "json") else {
        print("do not search file location")
        return
    }
    
    do{
        let jsonData = try Data(contentsOf: fileLocation)
        do{
            let decoder = try JSONDecoder().decode(ModelData.self, from: jsonData)
            completionHandler(decoder as! ModelData)
        }catch{
            print("JSON Data Error \(error)")
        }
    }catch{
        print("error")
    }
}

func fetchVideoData(completionHandler: (VideoData) -> Void){
    guard let fileLocation = Bundle.main.url(forResource: "videoList", withExtension: "json") else {
        print("do not search file location")
        return
    }
    
    do{
        let jsonData = try Data(contentsOf: fileLocation)
        do{
            let decoder = try JSONDecoder().decode(VideoData.self, from: jsonData)
            completionHandler(decoder as! VideoData)
        }catch{
            print("JSON Data Error \(error)")
        }
    }catch{
        print("error")
    }
}
