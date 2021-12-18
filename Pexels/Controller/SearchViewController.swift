//
//  SearchViewController.swift
//  Pexels
//
//  Created by GENKI Mac on 2021/12/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD
import SDWebImage
import RxSwift
import RxCocoa


class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    //定義
    @IBOutlet weak var searchber: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    let apiModel = ApiListModel()
    var apiGetlist:[ListItem] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲート設定
        tableview.delegate = self
        tableview.dataSource = self
        
        //RxSwift
        self.searchber.rx.text.orEmpty
            .filter { $0.count > 0 }
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { [unowned self] data in
                // 結果(data)を引数に次の関数に繋げる
                return self.apiModel.searchEvents(keyword: data)
            }
            .subscribe(onNext: {[weak self] getapi in
                if let events = getapi {
                    self!.apiGetlist = events.photos
                    self!.tableview.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    //Cellの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiGetlist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell定義
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cellのタグを使用し定義
        let contentsImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let Photographer = cell.contentView.viewWithTag(2) as! UILabel
        let ArtName = cell.contentView.viewWithTag(3) as! UILabel
        
        //値代入
        contentsImageView.sd_setImage(with:  URL(string:(apiGetlist[indexPath.row].src?.tiny)!), placeholderImage: nil, options: .continueInBackground, completed: nil)
        Photographer.text = "撮影者: " + apiGetlist[indexPath.row].photographer!
        ArtName.text = "【作品名】\n" + apiGetlist[indexPath.row].alt!
        
        return cell
    }
    
    //cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //cellをタップ時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //選択解除
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        //画面遷移
        let ViewController = self.storyboard?.instantiateViewController(identifier: "VC") as! ViewController
        ViewController.photoLargeUrl = (apiGetlist[indexPath.row].src?.large)!
        self.navigationController?.pushViewController(ViewController, animated: true)
    }

}
