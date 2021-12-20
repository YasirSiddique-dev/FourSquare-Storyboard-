//
//  VideoViewController.swift
//  FourSquare
//
//  Created by Yasir  on 12/2/21.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        //loading the player in layer
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "trailer", ofType: "mp4")!))
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        player.play()
        
    }
    //handling the back button
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
