//
//  Utilities.swift
//  CardViewListDemo
//
//  Created by Saiful I. Wicaksana on 11/13/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import UIKit

extension CardViewListDelegete {
    public func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String) {}
    public func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String, index: Int) {}
    public func cardView(_ scrollView: UIScrollView, willAttachCardViewController cardViewController: UIViewController, identifierCards identifier: String, index: Int) {}
    public func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViews cardViews: [UIView], identifierCards identifier: String) {}
    public func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViewControllers cardViewsController: [UIViewController], identifierCards identifier: String) {}
    public func cardView(_ scrollView: UIScrollView, didSelectCardView cardView: UIView, identifierCards identifier: String, index: Int) {}
}

extension UIView {
    func setX(x: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
    func setY(y: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    func setZ(z: CGFloat) {
        self.layer.zPosition = z
    }
    
    func setWidth(width: CGFloat) {
        var frame: CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height: CGFloat) {
        var frame: CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

class Utilities {
    
    internal func getWidthPercentOfView(view: UIView, percent: CGFloat) -> CGFloat {
        return view.bounds.width * (percent / 100)
    }
    
    internal func getHeightPercentOfView(view: UIView, percent: CGFloat) -> CGFloat {
        return view.bounds.height * (percent / 100)
    }
    
    internal func getWidthScreen() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    internal func getHeightScreen() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    internal func getFrameScreen() -> CGRect {
        return UIScreen.main.bounds
    }
}
