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


class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    //定義
    @IBOutlet weak var searchber: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    let disposeBag = DisposeBag()
    
    let apiModel = ApiListModel()
    var apiGetlist:[ListItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲート設定
        tableview.delegate = self
        tableview.dataSource = self
        searchber.delegate = self

    }
    
    
    // 検索バーキャンセルボタン有効化
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //キャセルボタン非表示
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //検索ボタン時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //キーボード閉じる。
        searchBar.endEditing(true)
        
        if(searchBar.text!.count == 0) {
            let alert = UIAlertController(title: "注意", message: "1文字以上で検索してください", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let getapi = apiModel.searchEvents(keyword: searchBar.text!)
            getapi.subscribe(onNext: {[weak self] getapi in
                if let events = getapi {
                    
                    if events.photos.isEmpty{
                        let alert = UIAlertController(title: "確認", message: "ヒットしませんでした", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(ok)
                        self!.present(alert, animated: true, completion: nil)
                    }else{
                        self!.apiGetlist = events.photos
                        self!.tableview.reloadData()
                    }
                }
            })
                .disposed(by: disposeBag)
        }
        
        

        
        
//        if(searchBar.text!.count == 0) {
//            let alert = UIAlertController(title: "注意", message: "1文字以上で検索してください", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(ok)
//            self.present(alert, animated: true, completion: nil)
//        } else {
//
//            //api取得
//            apiModel.searchEvents(keyword: searchBar.text!, success: {(api) in
//
//                //成功時の処理
//                HUD.hide()
//                print(api.photos)
//
//                if !api.photos.isEmpty{
//
//                    //apiGetlistに入れる
//                    self.apiGetlist = api.photos
//
//                    //テーブルを再読み込みする。
//                    self.tableview.reloadData()
//                }
//                else {
//
//                    let alert = UIAlertController(title: "確認", message: "ヒットしませんでした", preferredStyle: .alert)
//                    let ok = UIAlertAction(title: "OK", style: .default)
//                    alert.addAction(ok)
//                    self.present(alert, animated: true, completion: nil)
//                }
//
//            }, Error:{ (error) in
//                //成功時の処理
//                HUD.hide()
//
//                let alert = UIAlertController(title: "確認", message: "\(error)", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "OK", style: .default)
//                alert.addAction(ok)
//                self.present(alert, animated: true, completion: nil)
//
//            })
//        }
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
