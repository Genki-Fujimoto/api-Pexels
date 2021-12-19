//
//  ViewModel.swift
//  Pexels
//
//  Created by GENKI Mac on 2021/12/19.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewModel {
    
    let disposeBag = DisposeBag()
    let searchWordStream = PublishSubject<String>()
    let startedAtStream = PublishSubject<String>()
    let eventsStream = PublishSubject<Api?>()
    
    init() {
        //flatMapLatest → 一番新しい処理結果を利用
        searchWordStream.flatMapLatest{word -> Observable<Api?> in
            print("searchWord:\(word)")
            let model = ApiListModel()
            return  model.searchEvents(keyword: word).catchAndReturn(nil)
        }
        .subscribe(eventsStream)
        .disposed(by: disposeBag)
    }
}

// MARK: Observable
//データストリームを表現するクラス 実行者
extension ViewModel {
    var events: Observable<Api?> {
        return eventsStream.asObservable()
    }
}

// MARK: Observer
//Observableからデータストリームを受け取るクラス 監視者
extension ViewModel {
    var searchWord: AnyObserver<(String)> {
        return searchWordStream.asObserver()
    }
}


