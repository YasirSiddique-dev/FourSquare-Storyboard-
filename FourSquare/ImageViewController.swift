//
//  ImageViewController.swift
//  FourSquare
//
//  Created by Yasir  on 12/2/21.
//

import UIKit

class ImageViewController: UIViewController {
    //variables
    var row:Int!
    var count:Int!
    var imagesArray =  [images]()
    
    //outlets
    @IBOutlet weak var fullScreenImage: UIImageView!
    @IBOutlet weak var indexLbl: UILabel!
    
    // MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        //right swipe detection
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        //left swipe detection
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        indexLbl.text = String(row)
        loadImage(indexOfImage: row)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                if row > 0
                 {
                    row = row-1
                    loadImage(indexOfImage: row)
                    indexLbl.text = String(row)
                }
                else{
                    print("Reached End")
                }
                print("Swiped right")
            case .down:
                print("Swiped down")
            case .left:
                if row < count-1
                 {
                    row = row+1
                    loadImage(indexOfImage: row)
                    indexLbl.text = String(row)
                }
                 else
                 {
                    row = 0
                     loadImage(indexOfImage: row)
                     indexLbl.text = String(row)
                 }
                print("Swiped left")
                
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    //load image Function
    func loadImage(indexOfImage:Int)
    {
        let prefix = imagesArray[indexOfImage].prefix
        let suffix = imagesArray[indexOfImage].suffix
        let size = "original"
        let imgUrl = prefix+size+suffix
        fullScreenImage.downloaded(from: imgUrl)
        fullScreenImage.contentMode = .scaleAspectFit
    }

//handling back operation
@IBAction func backBtn(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
}
