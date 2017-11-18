//
//  ViewController.swift
//  CardViewListDemo
//
//  Created by Saiful I. Wicaksana on 11/13/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import CardViewList

class ViewController: UIViewController, CardViewListDelegete {
    
    fileprivate var cardViewList: CardViewList!
    fileprivate let horizontalCardIdentifier = "horizontalCard"
    fileprivate let verticalCardIdentifier = "verticalCard"
    @IBOutlet weak var cardContainerHorizontal: UIView!
    @IBOutlet weak var cardContainerVertical: UIView!
    @IBOutlet weak var cardContainerWithView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardViewList = CardViewList()
        self.cardViewList.delegete = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var cardViewControllers1 = [UIViewController]()
        for _ in 1 ... 25 {
            cardViewControllers1.append(CardTwoViewController(nibName: "CardTwoViewController", bundle: nil))
        }
        self.cardViewList.animationScroll = .transformToBottom
        self.cardViewList.isClickable = true
        self.cardViewList.clickAnimation = .bounce
        self.cardViewList.grid = 1
        self.cardViewList.generateCardViewList(containerView: cardContainerHorizontal, viewControllers: cardViewControllers1, listType: .horizontal, identifier: "horizontalCard")
        
        var cardViews1 = [UIView]()
        for _ in 1 ... 25 {
            let cardView = CardView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            cardViews1.append(cardView)
        }
        self.cardViewList.animationScroll = .scaleBounce
        self.cardViewList.isClickable = true
        self.cardViewList.clickAnimation = .bounce
        self.cardViewList.cardSizeType = .autoSize
        self.cardViewList.grid = 1
        self.cardViewList.generateCardViewList(containerView: cardContainerWithView, views: cardViews1, listType: .horizontal, identifier: "CardWithUIViews1")
        
        
        var cardViews2 = [UIView]()
        for _ in 1 ... 25 {
            let cardView = CardView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            cardViews2.append(cardView)
        }
        self.cardViewList.animationScroll = .transformToRight
        self.cardViewList.isClickable = true
        self.cardViewList.clickAnimation = .bounce
        self.cardViewList.cardSizeType = .autoSize
        self.cardViewList.grid = 2
        self.cardViewList.generateCardViewList(containerView: cardContainerVertical, views: cardViews2, listType: .vertical, identifier: "CardWithUIViews2")
        
        
        
        
//        var cardViewControllers2 = [UIViewController]()
//        for _ in 1 ... 25 {
//            cardViewControllers2.append(CardTwoViewController(nibName: "CardOneViewController", bundle: nil))
//        }
//        self.cardViewList.animationOpening = .scaleBounce
//        self.cardViewList.isClickable = true
//        self.cardViewList.clickAnimation = .bounce
//        self.cardViewList.cardSizeType = .autoSize
//        self.cardViewList.grid = 1
//        self.cardViewList.generateCardViewList(containerView: cardContainerVertical, viewControllers: cardViewControllers2, listType: .vertical, identifier: "verticalCard")
    }
    
    func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view will display!")
        } else {
            print("Vertical card view will display!")
        }
    }
    
    // You can control CardView from here
    func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String, index: Int) {
        print(cardView.frame)
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view attached!")
        } else {
            print("Vertical card view attached!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, willAttachCardViewController cardViewController: UIViewController, identifierCards identifier: String, index: Int) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view attached!")
        } else {
            print("Vertical card view attached!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViews cardViews: [UIView], identifierCards identifier: String) {
        print(cardViews.count)
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view finish display!")
        } else {
            print("Vertical card view finish display!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViewControllers cardViewsController: [UIViewController], identifierCards identifier: String) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view finish display!")
        } else {
            print("Vertical card view finish display!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, didSelectCardView cardView: UIView, identifierCards identifier: String, index: Int) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view finish display!")
        } else {
            print("Vertical card view finish display!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, didSelectCardViewController cardViewController: UIViewController, identifierCards identifier: String, index: Int) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view finish display!")
        } else {
            print("Vertical card view finish display!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

