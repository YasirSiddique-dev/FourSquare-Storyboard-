//
//  PlacesDetailViewController.swift
//  FourSquare
//
//  Created by Yasir  on 11/30/21.
//

import UIKit
import AVKit
import AVFoundation
class PlacesDetailViewController: UIViewController{
   
    
    @IBOutlet weak var imagesContainer: UIView!
    @IBOutlet weak var tipsContainer: UIView!
    @IBOutlet weak var nearbyPlacesContainer: UIView!
    
    //outlets
    @IBOutlet weak var restaurantCategory: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var coverImg: UIImageView!

    //variables
    var detail: results!
    let apiManager = APIManager()
    var imagesData =  [images]()
    
   // MARK: Main
    override func viewDidLoad() { 
        super.viewDidLoad()
     
        tipsContainer.isHidden = true
        nearbyPlacesContainer.isHidden = true
       //setting the restaurant name and category
        restaurantName.text = detail.name
        restaurantCategory.text = detail.categories.first?.name

    }

    override func viewWillAppear(_ animated: Bool) {
        apiManager.callImagesApi(fsq_id: detail.fsq_id) {  (results) in

            //stop loader
            if results.isEmpty
            {
                print("No Images Data")
            }
            else{
                self.imagesData = results
                //loading cover image
                    let prefix = self.imagesData[1].prefix
                    let suffix = self.imagesData[1].suffix
                    let size = "original"
                    let url = prefix+size+suffix
                    self.coverImg.downloaded(from: url)
                self.coverImg.contentMode = .scaleAspectFill
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imagesSegue"
        {
            let vc = segue.destination as! RestaurantImagesViewController
            vc.detailPlace = detail
        }
        else if segue.identifier == "tipsContainer"
        {
            let vc = segue.destination as! TipsViewController
            vc.detailPlace = detail
        }
        else if segue.identifier == "nearbyContainer"
        {
            let vc =  segue.destination as! NearbyPlacesViewController
            vc.detailPlace = detail
        }
    }
    
    
    @IBAction func didSegmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            imagesContainer.isHidden = false
            tipsContainer.isHidden = true
            nearbyPlacesContainer.isHidden = true
            
        }
        else if sender.selectedSegmentIndex == 1
        {
            tipsContainer.isHidden = false
            nearbyPlacesContainer.isHidden = true
            imagesContainer.isHidden = true
        }
        else if sender.selectedSegmentIndex == 2
        {
            nearbyPlacesContainer.isHidden = false
            imagesContainer.isHidden = true
            tipsContainer.isHidden = true
        }
                    
        
    }
    

    @IBAction func videoScreenBtn(_ sender: Any)
    {
       // performSegue(withIdentifier: "moveToVideo", sender: self)
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "trailer", ofType: "mp4")!))
        let vc = AVPlayerViewController()
                vc.player = player
                present(vc,animated: true)
    }
//
    //handling the back Button
    @IBAction func detailBackButton(_ sender: Any) {
       self.dismiss(animated: true)
       
 
    }
    
  

}
