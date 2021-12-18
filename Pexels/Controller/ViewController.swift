//
//  ViewController.swift
//  Pexels
//
//  Created by GENKI Mac on 2021/12/16.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var photoLargeUrl = String()
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画像表示
        imageview.sd_setImage(with:  URL(string:photoLargeUrl), placeholderImage: nil, options: .continueInBackground, completed: nil)
    }
}

