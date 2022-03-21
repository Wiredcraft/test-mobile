//
//  ReactiveExtension.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/19.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIScrollView {
    ///
    /// Shows if the bottom of the UIScrollView is reached.
    /// - parameter offset: A threshhold indicating the bottom of the UIScrollView.
    /// - returns: ControlEvent that emits when the bottom of the base UIScrollView is reached.
    ///
    public func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in }
        
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: UITableViewCell {
    public var prepareForReuse: RxSwift.Observable<Void> {
        var prepareForReuseKey: Int8 = 0
        if let prepareForReuseOB = objc_getAssociatedObject(base, &prepareForReuseKey) as? Observable<Void> {
            return prepareForReuseOB
        }

        let prepareForReuse = Observable.of(
            sentMessage(#selector(Base.prepareForReuse)).map { _ in }
            , deallocated)
            .merge()
        objc_setAssociatedObject(base, &prepareForReuseKey, prepareForReuse, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return prepareForReuse
    }
}

extension Reactive where Base: UIViewController {
    var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }
}
