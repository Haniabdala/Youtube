//
//  ViewController.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/19/20.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , ModelDelegate {
    

    var model = Model()
    var videos = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
        
        //Set itself as the datasource and the delegate
        
        //data source set the data
        //delegate deals with user interaction
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //self self as the delegate of the model
        
        model.delegate = self
    }
    
    //Passing the video through the segue to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Confirm that a video was selected
        
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        //Get a reference to the video that was tapped on
        
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        //Get a reference to the detail view controller
        
       let detailVC =  segue.destination as! DetailViewController
        
        //set the video property of the detail view controller
        detailVC.video = selectedVideo
    }
    
    
    //MARK: - Model Delegate
    
    func videosFetched(_ videos: [Video]) {
        // Set the returned vodeos to our video property
        
        self.videos = videos
        
        //Refresh the tableview
        
        tableView.reloadData() //will refire the datasource and delegate methods
    }
    
    
    
    
    //MARK: - Table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //datasource method
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //datasource method //this method is called for each row specified in the previous method if no row its not going to be called
        
        //Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID , for: indexPath) as! VideoTableViewCell
        
        //Configure the cell with the data
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        //Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //Delegate method
        
    }

}

