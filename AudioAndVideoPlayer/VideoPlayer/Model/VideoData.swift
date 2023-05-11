//
//  VideoData.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 20/03/23.
//

import Foundation

struct VideoData: Codable {
    let videoList: [VideoList]

    enum CodingKeys: String, CodingKey {
        case videoList = "VideoList"
    }
}

// MARK: - VideoList
struct VideoList: Codable {
    let titleName, describtion, img, trackName: String
}
