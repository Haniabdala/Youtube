//
//  Response.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/23/20.
//

import Foundation


struct Response : Decodable {
    
    var items : [Video]?
    
    
    enum CodingKeys : String , CodingKey {
         
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([Video].self , forKey: .items)
        
        
    }
    
    
}
