//
//  RestaurantImagesViewController.swift
//  FourSquare
//
//  Created by Yasir  on 12/3/21.
//

import UIKit

class RestaurantImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    //variables
    var spinner: UIView!
    var arrayCount:Int!
    var indexForImage:Int!
    let apiManager = APIManager()
    var imagesData =  [images]()
    var detailPlace: results!
    //outlets
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var indicationLbl1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicationLbl1.isHidden = true
        spinner = UIViewController.ShowSpinner(onView: self.view)
                //setting  layout items
                let layout = UICollectionViewFlowLayout()
                layout.itemSize = CGSize(width: 200, height: 230)
                layout.minimumInteritemSpacing = 0
                collectionView.collectionViewLayout = layout
    }
    
        // Handling the data in view will appear
        override func viewWillAppear(_ animated: Bool) {
            //calling the places images API
            apiManager.callImagesApi(fsq_id: detailPlace.fsq_id) {  (results) in
    
                //stop loader
                UIViewController.removeSpinner(spinner: self.spinner)
                self.collectionView.reloadData()
                //if data is empty
                if results.isEmpty
                {
                    self.indicationLbl1.isHidden = false
                    self.indicationLbl1.text = "No Data to Show"
                }
                //data us fetched
                else{
                    self.imagesData = results
                    self.indicationLbl1.isHidden = true
                    self.collectionView.reloadData()
                }
            }
    
        }
        //sending data to next viewController using segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == moveToShowImageScreen
            {
                let vc = segue.destination as! ImageViewController
                vc.imagesArray = imagesData
                vc.row = indexForImage
                vc.count = arrayCount
            }
        }
    
        // MARK: Collection View Delegates
    
        //handling the operation on click on row
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            indexForImage = indexPath.row
    
           performSegue(withIdentifier: moveToShowImageScreen, sender: self)
    
        }
        //handling the number of item in section
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            arrayCount = imagesData.count
            return  imagesData.count ?? 0
        }
        //handling the data in cells
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            let data = imagesData[indexPath.row]
            let prefix = data.prefix
            let suffix = data.suffix
            let size = "original"
            let imgUrl = prefix+size+suffix
            cell.imageBlock.downloaded(from: imgUrl)
            return cell
        }
    


}
