//
//  CardViewAnimation.swift
//  CardViewList
//
//  Created by Saiful I. Wicaksana on 17/11/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import UIKit

open class CardViewAnimation {
    
    fileprivate let util: Utilities = Utilities()
    
    public init() {}
    
    open func scale(to: CGFloat,view: UIView) {
        UIView.animate(withDuration: 0.2) {
            view.transform = CGAffineTransform(scaleX: to, y: to)
        }
    }
    
    open func scaleShow(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 2.0) {
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    open func scaleShowBounce(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        view.isHidden = false
        UIView.animate(withDuration: 0.0, animations: {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
    
    open func bounce(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
    
    open func bounce(view: UIView, completion: @escaping() -> ()) {
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 2.0, options: .allowUserInteraction, animations: {
                view.transform = CGAffineTransform.identity
            }, completion: { (_) in
                completion()
            })
        }
    }
    
    open func transformToRight(view: UIView) {
        let move = util.getWidthScreen()
        view.transform = CGAffineTransform(translationX: -move, y: 0)
        view.isHidden = false
        UIView.animate(withDuration: 0.3) {
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    open func transformToBottom(view: UIView) {
        let move = util.getWidthScreen()
        view.transform = CGAffineTransform(translationX: 0, y: -move)
        view.isHidden = false
        UIView.animate(withDuration: 0.3) {
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    open func transformToTop(view: UIView) {
        let move = util.getWidthScreen()
        view.transform = CGAffineTransform(translationX: 0, y: move)
        view.isHidden = false
        UIView.animate(withDuration: 0.3) {
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    open func transformToLeft(view: UIView) {
        let move = util.getWidthScreen()
        view.transform = CGAffineTransform(translationX: move, y: 0)
        view.isHidden = false
        UIView.animate(withDuration: 0.3) {
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
