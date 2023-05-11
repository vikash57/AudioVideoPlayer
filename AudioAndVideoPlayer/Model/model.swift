//
//  model.swift
//  AudioAndVideoPlayer
//
//  Created by Apple on 14/03/23.
//

import Foundation

struct ModelData: Codable {
    let music: [Music]
}

// MARK: - Music
struct Music: Codable {
    let titleName, describtion, img, trackName: String
}
