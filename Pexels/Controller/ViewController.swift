//
//  ViewController.swift
//  Pexels
//
//  Created by GENKI Mac on 2021/12/16.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var PhotoLargeUrl = String()
    
    @IBOutlet weak var Imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画像表示
        Imageview.sd_setImage(with:  URL(string:PhotoLargeUrl), placeholderImage: nil, options: .continueInBackground, completed: nil)
    }
}

