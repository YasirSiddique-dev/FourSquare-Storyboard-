//
//  NearbyPlacesViewController.swift
//  FourSquare
//
//  Created by Yasir  on 12/4/21.
//

import UIKit

class NearbyPlacesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   //variables
    var detailPlace: results!
    let apiManager = APIManager()
    var nearbyPlaces = [results]()
    var spinner: UIView!
    //outlets
   @IBOutlet weak var nearbyPlacesTableView: UITableView!
    @IBOutlet weak var indicationLbl3: UILabel!
    
    // MARK: Main Function
    override func viewDidLoad() {
        super.viewDidLoad()
        //show spinner
        spinner = UIViewController.ShowSpinner(onView: self.view)
        indicationLbl3.isHidden = true
    }
   
    override func viewWillAppear(_ animated: Bool) {
        //nearby places API Call
        apiManager.callNearbyPlacesApi(lat: detailPlace.geocodes.main.latitude, long: detailPlace.geocodes.main.longitude) { (data) in
            //data case
            switch data{
                //success condition
                case .success(let listOf):
                    self.nearbyPlaces = listOf.results
                    if self.nearbyPlaces.isEmpty //if there is no data
                    {
                        self.indicationLbl3.text = "No Data to Show"
                        self.indicationLbl3.isHidden  = false
                        UIViewController.removeSpinner(spinner: self.spinner)
                    }
                    else //if we have data
                    {
                        self.indicationLbl3.isHidden = true
                        self.nearbyPlacesTableView.reloadData()
                        UIViewController.removeSpinner(spinner: self.spinner)
                    }
                  
                //failure condition
                case .failure(let error):
                    print("Error Processing JSON Data \(error)")
                }
        }
    }
    //sending data using segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == moveToNearbyDeatils
        {
            let vc = segue.destination as! PlacesDetailViewController
            vc.detail = detailPlace
        }
    }

    // MARK: Table View Delegates
    
    // On row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailPlace = nearbyPlaces[indexPath.row]
        performSegue(withIdentifier: moveToNearbyDeatils, sender: self)
    }
    //return the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyPlaces.count
    }
    //setting data to cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearbyPlacesCell") as! NearbyPlacesTableViewCell
        //getting the image Url
        let prefix = nearbyPlaces[indexPath.row].categories.first?.icon.prefix
        let suffix = nearbyPlaces[indexPath.row].categories.first?.icon.suffix
        let size = "bg_120"
        let imgUrl = prefix!+size+suffix!
        //setup data to views in cell
        cell.nearbyPlaceName.text = nearbyPlaces[indexPath.row].name
        cell.nearbyPlaceCategory.text = nearbyPlaces[indexPath.row].categories.first?.name
        cell.nearbyPlaceDistance.text = "Distance: \(nearbyPlaces[indexPath.row].distance)"
        cell.nearbyPlaceImage.downloaded(from: imgUrl)
        //return the whole cell
        return cell
    }
    
    
}
