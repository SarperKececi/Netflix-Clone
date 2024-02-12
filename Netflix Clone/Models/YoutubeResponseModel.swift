//
//  YoutubeResponseModel.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 11.02.2024.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let etag: String
    let items: [YouTubeSearchResult]
    let kind: String
    let nextPageToken: String
    let pageInfo: YouTubePageInfo
    let regionCode: String
}

struct YouTubeSearchResult: Codable {
    let etag: String
    let id: YouTubeVideoID
    let kind: String
}

struct YouTubeVideoID: Codable {
    let channelId: String?
    let kind: String
    let videoId: String?
}

struct YouTubePageInfo: Codable {
    let resultsPerPage: Int
    let totalResults: Int
}
