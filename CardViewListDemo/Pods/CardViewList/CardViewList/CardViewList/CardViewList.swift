//
//  CardViewList.swift
//  CardViewListDemo
//
//  Created by Saiful I. Wicaksana on 11/13/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CardViewListDelegete {
    @objc optional func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String)
    @objc optional func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String)
    @objc optional func cardView(_ scrollView: UIScrollView, didFinishDisplay cardViews: [UIView], identifierCards identifier: String)
}

open class CardViewList {
    
    public enum ListType {
        case horizontal
        case vertical
    }
    
    fileprivate var util: Utilities = Utilities()
    fileprivate var scrollView: UIScrollView!
    fileprivate var containerView: UIView!
    fileprivate var cardViewControllers: [UIViewController]!
    fileprivate var cardViews: [UIView]!
    fileprivate var identifier: String = ""
    
    /** Set corner radius of card view in pixel */
    open var cornerRadius: CGFloat = 12.0
    /** Set shadow size of card view in pixel */
    open var shadowSize: CGFloat = 5.0
    /** Set shadow opacity of card view in 0 - 1 */
    open var shadowOpacity: Float = 0.9
    /** Set shadow color of card view. Default color is black */
    open var shadowColor: UIColor = UIColor.black
    /** Set margin of card view in percent(%) 0 - 100*/
    open var margin: CGFloat = 5
    /** Set list type horizontal or vertical */
    open var listType: ListType = .vertical
    /** Set center x card view. Default is true */
    open var isCenterX: Bool = true
    /** Set center y card view. Default is true */
    open var isCenterY: Bool = true
    /** Set the delegete of CardViewList */
    open var delegete: CardViewListDelegete!
    
    public init() {
        
    }
    
    /** Generate CardView list with UIViewController */
    open func generateCardViewList(containerView: UIView, cardViews: [UIViewController], listType: ListType, identifier: String) {
        self.containerView = containerView
        self.cardViewControllers = cardViews
        self.listType = listType
        self.identifier = identifier
        self.scrollView = UIScrollView(frame: containerView.bounds)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.generateCardList()
    }
    
    /** Generate CardView list with UIView */
    open func generateCardViewList(containerView: UIView, cardViews: [UIView], listType: ListType, identifier: String) {
        self.containerView = containerView
        self.cardViews = cardViews
        self.listType = listType
        self.identifier = identifier
        self.scrollView = UIScrollView(frame: containerView.bounds)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.generateCardList()
    }
    
    fileprivate func generateCardList() {
        let marginPercent = util.getWidthPercentOfView(view: containerView, percent: margin)
        var dynamicWidth: CGFloat = marginPercent
        var dynamicHeight: CGFloat = marginPercent
        var views: [UIView] = [UIView]()
        
        if delegete != nil {
            delegete.cardView!(willDisplay: scrollView, identifierCards: identifier)
        }
        
        if cardViewControllers != nil {
            for cardView in cardViewControllers {
                if delegete != nil {
                    delegete.cardView!(scrollView, willAttachCardView: cardView.view, identifierCards: identifier)
                }
                views.append(cardView.view)
                if self.listType == .horizontal {
                    cardViewSetting(view: cardView.view, dynamicValue: dynamicWidth)
                    dynamicWidth += (marginPercent + cardView.view.frame.width)
                } else {
                    cardViewSetting(view: cardView.view, dynamicValue: dynamicHeight)
                    dynamicHeight += (marginPercent + cardView.view.frame.height)
                }
            }
        } else if cardViews != nil {
            for cardView in cardViews {
                if delegete != nil {
                    delegete.cardView!(scrollView, willAttachCardView: cardView, identifierCards: identifier)
                }
                views.append(cardView)
                if self.listType == .horizontal {
                    cardViewSetting(view: cardView, dynamicValue: dynamicWidth)
                    dynamicWidth += (marginPercent + cardView.frame.width)
                } else {
                    cardViewSetting(view: cardView, dynamicValue: dynamicHeight)
                    dynamicHeight += (marginPercent + cardView.frame.height)
                }
            }
        }
        if self.listType == .horizontal {
            self.scrollView.contentSize.width = dynamicWidth
        } else {
            self.scrollView.contentSize.height = dynamicHeight
        }
        self.containerView.addSubview(self.scrollView)
        if delegete != nil {
            self.delegete.cardView!(scrollView, didFinishDisplay: views, identifierCards: identifier)
        }
    }
    
    fileprivate func cardViewSetting(view: UIView, dynamicValue: CGFloat) {
        let marginPercent = util.getWidthPercentOfView(view: containerView, percent: margin)
        let height = util.getHeightPercentOfView(view: containerView, percent: 100 - (margin * 2))
        let width = util.getHeightPercentOfView(view: containerView, percent: 100 - (margin * 2))
        if self.listType == .horizontal {
            view.setX(x: dynamicValue)
            view.setY(y: marginPercent)
            if view.bounds.height > height {
                view.setHeight(height: height)
            }
            if isCenterY {
                view.center.y = scrollView.center.y
            }
        } else {
            view.setX(x: marginPercent)
            view.setY(y: dynamicValue)
            if view.bounds.width > width {
                view.setWidth(width: width)
            }
            if isCenterX {
                view.center.x = scrollView.center.x
            }
        }
        
        let roundedView = UIView(frame: view.frame)
        roundedView.layer.shadowColor = shadowColor.cgColor
        roundedView.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
        roundedView.layer.shadowOffset = CGSize(width: shadowSize, height: shadowSize)
        roundedView.layer.shadowOpacity = shadowOpacity
        roundedView.layer.shadowRadius = cornerRadius
        
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        scrollView.addSubview(roundedView)
        scrollView.addSubview(view)
    }
}
