//
//  Extensions.swift
//  FourSquare
//
//  Created by Yasir  on 12/3/21.
//

import Foundation
import UIKit

// MARK: Loader Extension

extension UIViewController {
    //function for display spinner
    class func ShowSpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .white)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    //function for removing spinner
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

// MARK: Image Downloader extenstion

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

// MARK: SearchBarDelegate in Place view Controller

extension PlacesViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            searching = false
            tableView.reloadData()
            indicationLbl.isHidden = true
        }
        else
        {
            filterPlaces = places.filter({$0.name.lowercased().contains(searchText.lowercased())})
            
            if filterPlaces.isEmpty
            {
                //searching = false
                tableView.reloadData()
                indicationLbl.isHidden = false
                indicationLbl.text = "No Data found"
            }
            else
            {
                searching = true
                tableView.reloadData()
                indicationLbl.isHidden = true
            }
        }
       
       
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        indicationLbl.isHidden = true
        tableView.reloadData()
    }
}
