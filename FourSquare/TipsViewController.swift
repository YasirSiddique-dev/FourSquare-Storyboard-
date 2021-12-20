//
//  TipsViewController.swift
//  FourSquare
//
//  Created by Yasir  on 12/4/21.
//

import UIKit

class TipsViewController: UIViewController,UITableViewDataSource {
    //variables
    var tipsData = [Tips]()
    let apiManager = APIManager()
    var detailPlace: results!
    var spinner: UIView!
    //outlets
    @IBOutlet weak var tipsTableView: UITableView!
    @IBOutlet weak var indicationLbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicationLbl2.isHidden = true
        spinner = UIViewController.ShowSpinner(onView: self.view) //show loader
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        apiManager.callTipsApi(fsq_id: detailPlace.fsq_id) { (results) in
           // when there is no data in array
            if results.isEmpty
            {
                self.indicationLbl2.isHidden = false
                self.indicationLbl2.text = "No Data to Show"
                self.tipsTableView.reloadData()
                print("No Data Found")
                UIViewController.removeSpinner(spinner: self.spinner)
            }
            //when we get data
            else
            {
                self.indicationLbl2.isHidden = true
                UIViewController.removeSpinner(spinner: self.spinner)
                self.tipsData = results
                self.tipsTableView.reloadData()
            }
        }
    }
    
    // MARK: Table View Delegates
    
    //rows count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tipsData.count ?? 0
    }
    //setup data to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipsCell") as! TipsTableViewCell
        cell.tipsLbl.text = tipsData[indexPath.row].text
        return cell
    }
}
