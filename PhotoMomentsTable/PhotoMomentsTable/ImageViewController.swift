//
//  ImageViewController.swift
//  PhotoMomentsTable
//
//  Created by Marcel Chaucer on 1/20/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {

    @IBOutlet weak var theImage: UIImageView!
    var anImage = PHAsset()
    var manager = PHImageManager.default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.requestImage(for: anImage,
                             targetSize: CGSize(width: 300.0, height: 300.0),
                             contentMode: .aspectFill,
                             options: nil) { (result, _) in
                                self.theImage.image = result
                                
        }
    }
}
