//
//  PhotosTableViewController.swift
//  PhotoMomentsTable
//
//  Created by Marcel Chaucer on 1/20/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit
import Photos

class PhotosTableViewController: UITableViewController {

    var images = [PHAsset]()
    let manager = PHImageManager.default()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumMyPhotoStream, options:nil)
        for i in 0..<fetchResult.count {
            print("These are the fetch results: \(fetchResult[i])")
            let collection = fetchResult[i]
            print("This is the localized title: \(collection.localizedTitle ?? "")")
            
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            print("\n---\(assets.count)---\n")
            for j in 0..<assets.count {
                //print(assets[j])
                images.append(assets[j])
                
                if j > 10 {
                    break
                }
            }
        }

       
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
        let anImage = images[indexPath.row]
        
        manager.requestImage(for: anImage,
                             targetSize: CGSize(width: 100.0, height: 100.0),
                             contentMode: .aspectFill,
                             options: nil) { (result, _) in
                                cell.imageView?.image = result
                                
        }
        cell.textLabel?.text = String(describing: anImage.creationDate!)
        return cell
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! ImageViewController
        controller.anImage = images[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
