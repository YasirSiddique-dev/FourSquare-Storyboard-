//
//  PlacesViewController.swift
//  FourSquare
//
//  Created by Yasir  on 11/26/21.
//

import UIKit

class PlacesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    //variables
    
    let apiManager = APIManager()
    var places = [results]()
    var filterPlaces = [results]()
    var searchQuery: String!
    var latitude = 41.8781
    var longitude = -87.6298
    var searching = false
    var detail: results!
    
    //outlets
    
    @IBOutlet weak var indicationLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
       

      
        //staring loading on startup
        let spinner = UIViewController.ShowSpinner(onView: self.view)
        
        // MARK: Handling Data on Main Thread
        
        DispatchQueue.main.async { [self] in
            //caalling places API
            self.apiManager.callPlacesApi(query: searchQuery, lat: latitude, long: longitude) {(data) in
            switch data{
                //success condition
                case .success(let listOf):
                self.places = listOf.results
                //when no data in array
                if places.isEmpty{
                    indicationLbl.isHidden = false
                    indicationLbl.text = "No Data Found"
                    //stop loading when no data is returned
                    UIViewController.removeSpinner(spinner: spinner)
                }
                //when data is fetched
                else{
                    indicationLbl.isHidden = true
                    //stop loading when data is fetched
                    UIViewController.removeSpinner(spinner: spinner)
                    self.tableView.reloadData()
                }
                //failure condition
                case .failure(let error):
                    print("Error Processing JSON Data \(error)")
                }
            }
        }
    }
    
    //sending data to next viewController using segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == moveToDetailPlacesScreen
        {
            let destinationVC = segue.destination as! PlacesDetailViewController
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.detail = detail

       }
   }

    // MARK: Handling TableView Delegates
    
    //Handling the click operation on row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching
        {
            detail = filterPlaces[indexPath.row]
            performSegue(withIdentifier: moveToDetailPlacesScreen, sender: self)
        }
        else
        {
            detail = places[indexPath.row]
            performSegue(withIdentifier: moveToDetailPlacesScreen, sender: self)
        }
        
    }
    //Handling the number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching
        {
            return filterPlaces.count
        }
        else
        {
            return places.count
        }
    }
    //Handling Data on Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        //in Case of filtered data
        if searching
        {
            let data = filterPlaces[indexPath.row]
            setCellData(data: data, cell: cell)
        }
        //in case of all data
        else
        {
            let data = places[indexPath.row]
            setCellData(data: data, cell: cell)
        }
       
        return cell
    }
   
    //function to set data in cells
    func setCellData(data: results, cell: TableViewCell)
    {
        
        if let prefix = data.categories.first?.icon.prefix ,let suffix = data.categories.first?.icon.suffix
        {
            let size = "bg_120"
            let imgUrl = prefix+size+suffix
            cell.placeImage.downloaded(from: imgUrl)
        }
        else
        {
            print("No Icon to Show")
        }
        cell.placeName.text = data.name
        cell.placeDistance.text = "Distance: \(data.distance)"
        cell.placeProduct.text = data.categories.first?.name
    }
    
    //handling the back operation
    @IBAction func placesBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


