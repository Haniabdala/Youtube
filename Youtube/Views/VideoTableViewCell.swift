//
//  VideoTableViewCell.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/25/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video : Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v :Video){
        
        self.video = v
        
        //Ensure we have a video
        guard self.video != nil  else {
            return
        }
        
        //Set the title and date
        
        self.titleLabel.text = video?.title
        
        let dF = DateFormatter()
        
        dF.dateFormat = "EEEE, MMM d, yyyy"
         
        self.dateLabel.text = dF.string(from: video!.published)
        
        
        // Set the Thumbnail
        
        //Ensure the we have a thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //Check cache before downloading the data
        
        if let cacheData  =  CacheManager.getVideoCache(self.video!.thumbnail) {
            
            //Set the thumbnail
            
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        //Download the thumbnail data
        
        let url = URL(string: self.video!.thumbnail)
        
        //Get the shared URL Session object
        let session = URLSession.shared
        
        //Create a data task
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                
                //Save the data in the cache
                
                CacheManager.setVideoCache(url!.absoluteString, data!)
                
                
                //Check that the downloaded url matches the video thumbnail url that this cell is currently set to display (because these cells are recyclable could have a mismatch)
                
                if url!.absoluteString != self.video?.thumbnail{
                    //Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    
                    return
                }
                
                
                //create the image object
                
                let image = UIImage(data: data!)
                //Set the imageview
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
                
            }
        }
        
        //Start the data task
        
        dataTask.resume()
    }

}
