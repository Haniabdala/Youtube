//
//  Constants.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/23/20.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyC_IMTV5c15zCqJPM4tdejoMf7OjIogra8"
    static var PLAYLIST_ID = "PLMRqhzcHGw1ZkH8RuznGMS0NZs0jWQQ5a"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
}
