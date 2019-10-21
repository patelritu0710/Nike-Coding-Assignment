//
//  Feed.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import Foundation

struct Feed: Codable {
    
    var results: [FeedResult?]
}

struct Album: Codable {
    
    var feed: Feed?
}

struct FeedResult: Codable {
    
    var artistName: String?
    var name: String?
    var artworkUrl100: String?
}
