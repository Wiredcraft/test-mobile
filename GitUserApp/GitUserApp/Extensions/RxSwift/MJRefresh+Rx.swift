//
//  MJRefresh+Rx.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

extension Reactive where Base: MJRefreshComponent {
     
    // begin refreshing event
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }

    // end refresh event
    var loding: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if !isEnd {
                refresh.endRefreshing()
            }
        }
    }
}
