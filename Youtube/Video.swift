//
//  Video.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/23/20.
//

import Foundation

struct Video :Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys : String , CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt" //we only spesify value if the keyword doesn't match in the json response
        case videoId
        case title
        case description
        case thumbnail = "url" //found under thumbnails
     
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse Title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)

        // Parse publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        //parse thumbnails
        
        let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self , forKey: .thumbnails)
        
        let highContainer = try thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // parse videoID
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
    }
    
    
}
