//
//  Model.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/23/20.
//

import Foundation


protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model {
    var delegate:ModelDelegate?
    func getVideos() {
        
        
        // Create a URL object
        
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // Get a URLSession object
        
        let session = URLSession.shared
        
        // Get a data task from the URLSession object(represent a single call to the API)
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            
            //check if there were any errors
            
            if error != nil || data == nil {
                return
            }
            
            //Parsing the data
            do { //since this methods throw we need to wrap it in do block + using try
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601 //to specify the format of dates if u find them in the json
                
             let response = try decoder.decode(Response.self , from: data!)
                
                //Call the "videosFetched " method of the delegate
                
                
                if response.items != nil{
                    DispatchQueue.main.async { //reload tableview can only be called in the main thread
                        self.delegate?.videosFetched(response.items!)
                    }
           
                }
                dump(response) //output everything in response to the console
            }
            catch
            {
                
            }
           
            
            
        }
        // Kick off the task
        dataTask.resume()
        
    }
}
