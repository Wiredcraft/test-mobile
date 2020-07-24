//
//  MJRefresh+Rx.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/24.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

extension Reactive where Base: MJRefreshComponent {

  var refreshing: ControlEvent<Void> {
    let source: Observable<Void> = Observable.create {
      [weak control = self.base] observer in
      if let control = control {
        control.refreshingBlock = {
          observer.on(.next(()))
        }
      }
      return Disposables.create()
    }
    return ControlEvent(events: source)
  }
}

