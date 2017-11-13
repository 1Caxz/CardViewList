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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardViewList = CardViewList()
        self.cardViewList.delegete = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cardViews1 = [CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil), CardTwoViewController(nibName: "CardTwoViewController", bundle: nil)]
        let cardViews2 = [CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil)]
        self.cardViewList.generateCardViewList(containerView: cardContainerHorizontal, cardViews: cardViews1, listType: .horizontal, identifier: "horizontalCard")
        self.cardViewList.generateCardViewList(containerView: cardContainerVertical, cardViews: cardViews2, listType: .vertical, identifier: "verticalCard")
    }
    
    func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view will display!")
        } else {
            print("Vertical card view will display!")
        }
    }
    
    // You can control CardView from here
    func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String) {
        if identifier == horizontalCardIdentifier {
            print("Horizontal card view attached!")
        } else {
            print("Vertical card view attached!")
        }
    }
    
    func cardView(_ scrollView: UIScrollView, didFinishDisplay cardViews: [UIView], identifierCards identifier: String) {
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

