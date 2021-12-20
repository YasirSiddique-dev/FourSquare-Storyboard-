//
//  ViewController.swift
//  FourSquare
//
//  Created by Yasir  on 11/25/21.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //variables
    
    var locationManager:CLLocationManager!
    var currentLatitude,currentLongitude : Double!
    var query:String!
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchBtn(_ sender: Any) {
        let searchQuery = searchField.text
        //let trimming = searchQuery?.filter{!$0.isWhitespace}
        let trim = searchQuery?.replacingOccurrences(of: " ", with: "%20")
        
        if searchQuery == ""
            {
            print("Field is empty")
        }
        else{
            query = trim
            performSegue(withIdentifier: moveToPlacesScreen, sender: self)
        }
    }
    // MARK: Main 
    override func viewDidLoad() {
        super.viewDidLoad()
            //Initializing Location Manager
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }
    }
    
    //sending search query to next page using Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == moveToPlacesScreen
        {
            let destinationVC = segue.destination as! PlacesViewController
            destinationVC.searchQuery = query
            destinationVC.modalPresentationStyle = .fullScreen
            // destinationVC.latitude = currentLatitude
            //destinationVC.longitude = currentLongitude
       }
   }
    
// MARK:  Assiging actions on buttons and save query

    @IBAction func breakFastBtn(_ sender: Any){
        query = breakFastQuery
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    @IBAction func lunchBtn(_ sender: Any) {
        query = lunchQuery
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    @IBAction func dinnerBtn(_ sender: Any) {
        query = dinnerQuery
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    @IBAction func coffeeBtn(_ sender: Any) {
        query = coffeeAndTeaQuery
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    @IBAction func nightBtn(_ sender: Any) {
        query = nightLifeQuery
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    @IBAction func thingsBtn(_ sender: Any) {
        query = things
        performSegue(withIdentifier: moveToPlacesScreen, sender: self)
    }
    
    
// MARK: Location Manager Delegatess
    //Handling Location on Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        currentLatitude = userLocation.coordinate.longitude
        currentLongitude = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

    }
    //Handling Error in case of failure
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
  
}

