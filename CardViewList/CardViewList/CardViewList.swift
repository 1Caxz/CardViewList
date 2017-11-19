//
//  CardViewList.swift
//  CardViewListDemo
//
//  Created by Saiful I. Wicaksana on 11/13/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import UIKit

public protocol CardViewListDelegete: class {
    func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String, index: Int)
    func cardView(_ scrollView: UIScrollView, willAttachCardViewController cardViewController: UIViewController, identifierCards identifier: String, index: Int)
    
    func cardView(_ scrollView: UIScrollView, didSelectCardView cardView: UIView, identifierCards identifier: String, index: Int)
    
    func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String)
    
    func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViews cardViews: [UIView], identifierCards identifier: String)
    func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViewControllers cardViewsController: [UIViewController], identifierCards identifier: String)
}

open class CardViewList: NSObject, UIScrollViewDelegate {
    
    public enum ListType {
        case horizontal
        case vertical
    }
    
    public enum CardSizeType {
        case autoSize
        case square
        case circle
    }
    
    public enum AnimationScroll: String {
        case none = "none"
        case scaleBounce = "scaleBounce"
        case transformToRight = "transformToRight"
        case transformToLeft = "transformToLeft"
        case transformToBottom = "transformToBottom"
        case transformToTop = "transformToTop"
    }
    
    public enum ClickAnimation {
        case none
        case bounce
    }
    
    fileprivate var util: Utilities = Utilities()
    fileprivate var cardViewAnimation: CardViewAnimation = CardViewAnimation()
    fileprivate var containerView: UIView!
    fileprivate var cardViewControllers: [UIViewController] = [UIViewController]()
    fileprivate var cardViews: [UIView] = [UIView]()
    fileprivate var dynamicX: CGFloat = 0
    fileprivate var dynamicY: CGFloat = 0
    fileprivate var marginPercent: CGFloat = 0
    fileprivate var marginCardsPercent: CGFloat = 0
    fileprivate var identifier: String = ""
    fileprivate var manualSize: CGSize!
    fileprivate var gridCounter: Int = 0
    
    /** Set disable/enable shadow of CardView. Default is true */
    open var isShadowEnable: Bool = true
    /** Set disable/enable click of CardView. Default is false */
    open var isClickable: Bool = false
    /** Set multiple touch of CardView. Default is false */
    open var isMultipleTouch: Bool = false
    /** Set corner radius of card view in pixel. Default is 12.0 */
    open var cornerRadius: CGFloat = 12.0
    /** Set shadow size of card view in pixel. Default is 5.0 */
    open var shadowSize: CGFloat = 5.0
    /** Set shadow opacity of card view in 0 - 1. Default is 0.9 */
    open var shadowOpacity: Float = 0.9
    /** Set shadow color of card view. Default color is black */
    open var shadowColor: UIColor = UIColor.black
    /** Set CardView margin in percent(%) of containerView. Default is 5 */
    open var margin: CGFloat = 5
    /** Set margin between CardView in percent(%) of containerView. Default is 5 */
    open var marginCards: CGFloat = 5
    /** Set list type horizontal, vertical, horizontalVertical. Default is vertical */
    open var listType: ListType = .vertical
    /** Set grid List of CardView. Default is 1 */
    open var grid: Int = 1
    /** Set size of CardView. Default is autoSize */
    open var cardSizeType: CardSizeType = .autoSize
    /** Set max width of CardView in percent(%) of containerView. Default is 100 */
    open var maxWidth: CGFloat = 100
    /** Set max height of CardView in percent(%) of containerView. Default is 100 */
    open var maxHeight: CGFloat = 100
    /** Set animation when CardView showing. Default is none */
    open var animationScroll: AnimationScroll = .none
    /** Set animation click for CardView. Default is none */
    open var clickAnimation: ClickAnimation = .none
    /** Set the delegete of CardViewList */
    open var delegete: CardViewListDelegete!
    
    public override init() {
        
    }
    
    /** Generate CardView list with UIViewController */
    open func generateCardViewList(containerView: UIView, viewControllers: [UIViewController], listType: ListType, identifier: String) {
        // Change the margin in percent
        self.marginPercent = util.getWidthPercentOfView(view: containerView, percent: margin)
        self.marginCardsPercent = util.getWidthPercentOfView(view: containerView, percent: marginCards)
        
        self.cardViewControllers.removeAll()
        self.cardViews.removeAll()
        self.containerView = containerView
        self.cardViewControllers = viewControllers
        self.listType = listType
        self.identifier = identifier
        self.gridCounter = 0
        
        let scrollView = UIScrollView(frame: containerView.bounds)
        scrollView.delegate = self
        scrollView.accessibilityIdentifier = identifier
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.generateCardList(scrollView: scrollView)
    }
    
    /** Generate CardView list with UIView */
    open func generateCardViewList(containerView: UIView, views: [UIView], listType: ListType, identifier: String) {
        // Change the margin in percent
        self.marginPercent = util.getWidthPercentOfView(view: containerView, percent: margin)
        self.marginCardsPercent = util.getWidthPercentOfView(view: containerView, percent: marginCards)
        
        self.cardViewControllers.removeAll()
        self.cardViews.removeAll()
        self.containerView = containerView
        self.cardViews = views
        self.listType = listType
        self.identifier = identifier
        self.gridCounter = 0
        
        let scrollView = UIScrollView(frame: containerView.bounds)
        scrollView.delegate = self
        scrollView.accessibilityIdentifier = identifier
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.generateCardList(scrollView: scrollView)
    }
    
    fileprivate func generateCardList(scrollView: UIScrollView) {
        self.dynamicX = marginPercent
        self.dynamicY = marginPercent
        self.maxWidth = util.getWidthPercentOfView(view: containerView, percent: (self.maxWidth - (margin * 2)))
        self.maxHeight = util.getHeightPercentOfView(view: containerView, percent: (self.maxHeight - (margin * 2)))
        
        if delegete != nil {
            delegete.cardView(willDisplay: scrollView, identifierCards: identifier)
        }
        
        if cardViewControllers.count > 0 {
            for i in 0 ..< cardViewControllers.count {
                self.setSize(scrollView: scrollView, view: cardViewControllers[i].view)
                if delegete != nil {
                    delegete.cardView(scrollView, willAttachCardViewController: cardViewControllers[i], identifierCards: identifier, index: i)
                }
                cardViewControllers[i].view.tag = (i + 1)
                self.cardViewSetting(scrollView: scrollView,view: cardViewControllers[i].view)
            }
        } else if cardViews.count > 0 {
            for i in 0 ..< cardViews.count  {
                self.setSize(scrollView: scrollView, view: cardViews[i])
                if delegete != nil {
                    delegete.cardView(scrollView, willAttachCardView: cardViews[i], identifierCards: identifier, index: i)
                }
                cardViews[i].tag = (i + 1)
                self.cardViewSetting(scrollView: scrollView, view: cardViews[i])
            }
        }
        
        if listType == .horizontal {
            scrollView.contentSize.width = dynamicX
        } else if listType == .vertical {
            scrollView.contentSize.height = dynamicY
        }
        
        self.containerView.addSubview(scrollView)
        if delegete != nil {
            if cardViewControllers.count > 0 {
                delegete.cardView(scrollView, didFinishDisplayCardViewControllers: cardViewControllers, identifierCards: identifier)
            } else if cardViews.count > 0 {
                delegete.cardView(scrollView, didFinishDisplayCardViews: cardViews, identifierCards: identifier)
            }
        }
        startAnimation(scrollView: scrollView)
    }
    
    fileprivate func cardViewSetting(scrollView: UIScrollView, view: UIView) {
        var roundedView: UIView!
        let width = view.frame.width
        let height = view.frame.height
        view.accessibilityIdentifier = self.identifier
        view.accessibilityValue = self.animationScroll.rawValue
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        
        if isShadowEnable {
            roundedView = UIView(frame: view.frame)
            roundedView.tag = view.tag
            if cardSizeType == .circle {
                roundedView.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: width / 2).cgPath
                view.layer.cornerRadius = width / 2
                view.layer.shadowRadius = width / 2
            } else {
                roundedView.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
                roundedView.layer.shadowRadius = cornerRadius
            }
            roundedView.layer.shadowColor = shadowColor.cgColor
            roundedView.layer.shadowOffset = CGSize(width: shadowSize, height: shadowSize)
            roundedView.layer.shadowOpacity = shadowOpacity
            scrollView.addSubview(roundedView)
        }
        
        scrollView.addSubview(view)
        self.setDynamicPosition(view: view, width: width, height: height)
        if clickAnimation != .none || isClickable {
            let tGesture = UITapGestureRecognizer(target: self, action: #selector(touchGesture))
            view.addGestureRecognizer(tGesture)
            view.isExclusiveTouch = !isMultipleTouch
        }
        if animationScroll != .none {
            view.isHidden = true
            if isShadowEnable {
                roundedView.isHidden = true
            }
        }
    }
    
    fileprivate func setSize(scrollView: UIScrollView, view: UIView) {
        var height: CGFloat!
        var width: CGFloat!
        let marginCardTotal: CGFloat = (marginCards * CGFloat(grid - 1)) + (margin * 2)
        if grid <= 1 {
            if cardSizeType == .autoSize {
                if listType == .horizontal {
                    width = view.frame.width > maxWidth ? maxWidth : view.frame.width
                    height = util.getHeightPercentOfView(view: containerView, percent: 100 - marginCardTotal)
                    height = height > maxHeight ? maxHeight : height
                } else if listType == .vertical {
                    width = util.getWidthPercentOfView(view: containerView, percent: 100 - marginCardTotal)
                    width = width > maxWidth ? maxWidth : width
                    height = view.frame.height > maxHeight ? maxHeight : view.frame.height
                }
            } else if cardSizeType == .square || cardSizeType == .circle {
                let containerWidth = containerView.frame.width
                let containerHeight = containerView.frame.height
                if containerWidth < containerHeight {
                    width = util.getWidthPercentOfView(view: containerView, percent: 100 - marginCardTotal)
                    width = width > maxWidth ? maxWidth : width
                    height = width
                } else {
                    height = util.getHeightPercentOfView(view: containerView, percent: 100 - marginCardTotal)
                    height = height > maxHeight ? maxHeight : height
                    width = height
                }
            }
        } else {
            if cardSizeType == .autoSize {
                if listType == .horizontal {
                    width = view.frame.width > maxWidth ? maxWidth : view.frame.width
                    height = util.getHeightPercentOfView(view: containerView, percent: (100 - marginCardTotal) / CGFloat(grid))
                    height = height > maxHeight ? maxHeight : height
                } else if listType == .vertical {
                    width = util.getWidthPercentOfView(view: containerView, percent: (100 - marginCardTotal) / CGFloat(grid))
                    width = width > maxWidth ? maxWidth : width
                    height = view.frame.height > maxHeight ? maxHeight : view.frame.height
                }
            } else if cardSizeType == .square || cardSizeType == .circle {
                let containerWidth = containerView.frame.width
                let containerHeight = containerView.frame.height
                if containerWidth < containerHeight {
                    width = util.getWidthPercentOfView(view: containerView, percent: (100 - marginCardTotal) / CGFloat(grid))
                    width = width > maxWidth ? maxWidth : width
                    height = width
                } else {
                    height = util.getHeightPercentOfView(view: containerView, percent: (100 - marginCardTotal) / CGFloat(grid))
                    height = height > maxHeight ? maxHeight : height
                    width = height
                }
            }
        }
        view.setX(x: dynamicX)
        view.setY(y: dynamicY)
        view.setWidth(width: width)
        view.setHeight(height: height)
        
        if grid <= 1 {
            if self.listType == .horizontal {
                view.center.y = scrollView.center.y
            } else if self.listType == .vertical {
                view.center.x = scrollView.center.x
            }
        }
    }
    
    fileprivate func setDynamicPosition(view: UIView, width: CGFloat, height: CGFloat) {
        self.gridCounter += 1
        if cardViewControllers.count > 0 {
            if cardViewControllers.count > 0 {
                if listType == .horizontal {
                    if grid <= 1 {
                        if cardViewControllers.last?.view == view {
                            dynamicX += (marginPercent + width)
                        } else {
                            dynamicX += (marginCardsPercent + width)
                        }
                    } else {
                        if gridCounter == grid {
                            if cardViewControllers.last?.view == view {
                                dynamicX += (marginPercent + width)
                            } else {
                                dynamicX += (marginCardsPercent + width)
                            }
                            dynamicY = marginPercent
                        } else {
                            if cardViewControllers.last?.view == view {
                                dynamicX += (marginPercent + width)
                                dynamicY += (marginPercent + height)
                            } else {
                                dynamicY += (marginCardsPercent + height)
                            }
                        }
                        if gridCounter == grid {
                            self.gridCounter = 0
                        }
                    }
                } else if listType == .vertical {
                    if grid <= 1 {
                        if cardViewControllers.last?.view == view {
                            dynamicY += (marginPercent + height)
                        } else {
                            dynamicY += (marginCardsPercent + height)
                        }
                    } else {
                        if gridCounter == grid {
                            if cardViewControllers.last?.view == view {
                                dynamicY += (marginPercent + height)
                            } else {
                                dynamicY += (marginCardsPercent + height)
                            }
                            dynamicX = marginPercent
                        } else {
                            if cardViewControllers.last?.view == view {
                                dynamicY += (marginPercent + height)
                                dynamicX += (marginPercent + width)
                            } else {
                                dynamicX += (marginCardsPercent + width)
                            }
                        }
                        if gridCounter == grid {
                            self.gridCounter = 0
                        }
                    }
                }
            }
        } else if cardViews.count > 0 {
            if cardViews.count > 0 {
                if listType == .horizontal {
                    if grid <= 1 {
                        if cardViews.last == view {
                            dynamicX += (marginPercent + width)
                        } else {
                            dynamicX += (marginCardsPercent + width)
                        }
                    } else {
                        if gridCounter == grid {
                            if cardViews.last == view {
                                dynamicX += (marginPercent + width)
                            } else {
                                dynamicX += (marginCardsPercent + width)
                            }
                            dynamicY = marginPercent
                        } else {
                            if cardViews.last == view {
                                dynamicX += (marginPercent + width)
                                dynamicY += (marginPercent + height)
                            } else {
                                dynamicY += (marginCardsPercent + height)
                            }
                        }
                        if gridCounter == grid {
                            self.gridCounter = 0
                        }
                    }
                } else if listType == .vertical {
                    if grid <= 1 {
                        if cardViews.last == view {
                            dynamicY += (marginPercent + height)
                        } else {
                            dynamicY += (marginCardsPercent + height)
                        }
                    } else {
                        if gridCounter == grid {
                            if cardViews.last == view {
                                dynamicY += (marginPercent + height)
                            } else {
                                dynamicY += (marginCardsPercent + height)
                            }
                            dynamicX = marginPercent
                        } else {
                            if cardViews.last == view {
                                dynamicY += (marginPercent + height)
                                dynamicX += (marginPercent + width)
                            } else {
                                dynamicX += (marginCardsPercent + width)
                            }
                        }
                        if gridCounter == grid {
                            self.gridCounter = 0
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func startAnimation(scrollView: UIScrollView) {
        for subview in scrollView.subviews {
            if scrollView.bounds.intersects(subview.frame) && subview.isHidden {
                if subview.accessibilityValue == AnimationScroll.scaleBounce.rawValue {
                    cardViewAnimation.scaleShowBounce(view: subview)
                    cardViewAnimation.scaleShowBounce(view: scrollView.viewWithTag(subview.tag)!)
                } else if subview.accessibilityValue == AnimationScroll.transformToRight.rawValue {
                    cardViewAnimation.transformToRight(view: subview)
                    cardViewAnimation.transformToRight(view: scrollView.viewWithTag(subview.tag)!)
                } else if subview.accessibilityValue == AnimationScroll.transformToLeft.rawValue {
                    cardViewAnimation.transformToLeft(view: subview)
                    cardViewAnimation.transformToLeft(view: scrollView.viewWithTag(subview.tag)!)
                } else if subview.accessibilityValue == AnimationScroll.transformToTop.rawValue {
                    cardViewAnimation.transformToTop(view: subview)
                    cardViewAnimation.transformToTop(view: scrollView.viewWithTag(subview.tag)!)
                } else if subview.accessibilityValue == AnimationScroll.transformToBottom.rawValue {
                    cardViewAnimation.transformToBottom(view: subview)
                    cardViewAnimation.transformToBottom(view: scrollView.viewWithTag(subview.tag)!)
                }
            } else if !scrollView.bounds.intersects(subview.frame) && !subview.isHidden {
                subview.isHidden = true
            }
        }
    }
    
    @objc internal func touchGesture(sender: UITapGestureRecognizer) {
        if clickAnimation != .none || isClickable {
            if let scrollView = sender.view?.superview as? UIScrollView {
                if let shadowView = scrollView.viewWithTag((sender.view?.tag)!) {
                    if isClickable && clickAnimation != .none {
                        cardViewAnimation.bounce(view: shadowView)
                        cardViewAnimation.bounce(view: sender.view!, completion: {
                            if self.delegete != nil {
                                self.delegete.cardView(scrollView, didSelectCardView: sender.view!, identifierCards: (sender.view?.accessibilityIdentifier)!, index: sender.view!.tag - 1)
                            }
                        })
                    } else if clickAnimation != .none {
                        cardViewAnimation.bounce(view: sender.view!)
                        cardViewAnimation.bounce(view: shadowView)
                    }
                }
            }
        }
        if isClickable && clickAnimation == .none {
            if let scrollView = sender.view?.superview as? UIScrollView {
                if delegete != nil {
                    delegete.cardView(scrollView, didSelectCardView: sender.view!, identifierCards: (sender.view?.accessibilityIdentifier)!, index: sender.view!.tag - 1)
                }
            }
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        startAnimation(scrollView: scrollView)
    }
}

