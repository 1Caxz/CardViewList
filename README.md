# CardViewList
[![Creator](https://img.shields.io/badge/creator-icaksama-green.svg)](https://www.linkedin.com/in/icaksama/)
[![Travis](https://img.shields.io/travis/icaksama/CardViewList.svg)](https://travis-ci.org/icaksama/CardViewList)
[![GitHub license](https://img.shields.io/github/license/icaksama/CardViewList.svg)](https://raw.githubusercontent.com/icaksama/CardViewList/master/LICENSE)
[![Code Size](https://img.shields.io/github/languages/code-size/icaksama/CardViewList.svg)](https://cocoapods.org/pods/CardViewList)
[![Pod Version](https://img.shields.io/cocoapods/v/CardViewList.svg)](https://cocoapods.org/pods/CardViewList)
[![Platform](https://img.shields.io/cocoapods/p/CardViewList.svg)](https://cocoapods.org/pods/CardViewList)
[![Download Total](https://img.shields.io/cocoapods/dt/CardViewList.svg)](https://cocoapods.org/pods/CardViewList)
<br>
Create CardView like Android easier on iOS. This library provides horizontal and vertical scrolling with many features inside.

## Features
- [x] Support swift 4 and iOS 8 above
- [x] Suport vertical and horizontal scrolling
- [x] CardView can be customized
- [x] CardView shandow
- [x] Clickable CardView
- [x] Multi touch CardView
- [x] Responsive design
- [x] Awesome scrolling and touch animation
- [x] EASY TO USE & FAST!

## Preview
<p align="center">
<img width="450" src="https://github.com/icaksama/CardViewList/blob/master/iPadResponsive.gif?raw=true">&nbsp;&nbsp;&nbsp;
<img width="350" src="https://github.com/icaksama/CardViewList/blob/master/iPhoneResponsive.gif?raw=true">
</p>

## Add to Podfile
Add CardViewList library to your Podfile and install.
```text
pod 'CardViewList', '~> 1.1.8'
```

## Import Library
Add import CardViewList library in your class before use this library.
```swift
import CardViewList
```

## Add CardViewListDelegete
Add <b>CardViewListDelegete</b> in your Class/ViewController
```swift
class ViewController: UIViewController, CardViewListDelegete {
```

## Add Method Delegete
Method delegete is optional. But you can add them to your code for detecting some condition for your programs. Please define the method depend on CardView from UIView/UIViewController.
```swift
// Response when CardView will Display.
func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String) {}

// Response when every single of CardView from UIView will attach.
func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String, index: Int) {}

// Response when every single of CardView from UIViewController will attach.
func cardView(_ scrollView: UIScrollView, willAttachCardViewController cardViewController: UIViewController, identifierCards identifier: String, index: Int) {}

// Response when CardView from UIView did finish attached.
func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViews cardViews: [UIView], identifierCards identifier: String) {}

// Response when CardView from UIViewController did finish attached.
func cardView(_ scrollView: UIScrollView, didFinishDisplayCardViewControllers cardViewsController: [UIViewController], identifierCards identifier: String) {}

// Response when CardView is selected.
func cardView(_ scrollView: UIScrollView, didSelectCardView cardView: UIView, identifierCards identifier: String, index: Int) {}
```

## Create CardView List with UIViewControler
First, You need to create your UIViewControler as CardView. You can see the demo project.
Make sure run this program inside viewDidAppear for best appearance. <b>"identifier"</b> will let you create more than one CardView list in one page and detect it with the identifier.
```swift
fileprivate var cardViewList: CardViewList!
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.cardViewList = CardViewList()
    self.cardViewList.delegete = self
    
    // Create CardView List from UIViewController
    var cardViewControllers = [UIViewController]()
    for _ in 1 ... 25 {
        cardViewControllers.append(CardViewController(nibName: "CardViewController", bundle: nil))
    }
    self.cardViewList.animationScroll = .transformToBottom
    self.cardViewList.isClickable = true
    self.cardViewList.clickAnimation = .bounce
    self.cardViewList.grid = 1
    self.cardViewList.generateCardViewList(containerView: self.view, viewControllers: cardViewControllers, listType: .horizontal, identifier: "CardWithUIViewController")
}
```

## Create CardView List with UIView
First, You need to create your Views as CardView. You can see in the demo project.
Make sure run this program inside viewDidAppear for best appearance. <b>"identifier"</b> will let you create more than one CardView list in one page and detect it with the identifier.
```swift
fileprivate var cardViewList: CardViewList!
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.cardViewList = CardViewList()
    self.cardViewList.delegete = self
    
    // Create CardView List from UIView
    var cardViews = [UIView]()
    for _ in 1 ... 25 {
        cardViews.append(UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)))
    }
    self.cardViewList.animationScroll = .scaleBounce
    self.cardViewList.isClickable = true
    self.cardViewList.clickAnimation = .bounce
    self.cardViewList.cardSizeType = .autoSize
    self.cardViewList.grid = 1
    self.cardViewList.generateCardViewList(containerView: self.view, views: cardViews, listType: .vertical, identifier: "CardWithUIView")
}
```

## CardView Setting
Setting the CardView before generate CardView List.
```swift
/** Set disable/enable shadow of CardView. Default is true */
cardViewList.isShadowEnable = true
    
/** Set disable/enable click of CardView. Default is false */
cardViewList.isClickable = false
    
/** Set multiple touch of CardView. Default is false */
cardViewList.isMultipleTouch = false
    
/** Set corner radius of card view in pixel. Default is 12.0 */
cardViewList.cornerRadius = 12.0
    
/** Set shadow size of card view in pixel. Default is 5.0 */
cardViewList.shadowSize = 5.0
    
/** Set shadow opacity of card view in 0 - 1. Default is 0.9 */
cardViewList.shadowOpacity = 0.9
    
/** Set shadow color of card view. Default color is black */
cardViewList.shadowColor = UIColor.black
    
/** Set CardView margin in percent(%) of containerView. Default is 5 */
cardViewList.margin = 5
    
/** Set margin between CardView in percent(%) of containerView. Default is 5 */
cardViewList.marginCards = 5
    
/** Set list type horizontal, vertical, horizontalVertical. Default is vertical */
cardViewList.listType = .vertical
    
/** Set grid List of CardView. Default is 1 */
cardViewList.grid = 1
    
/** Set size of CardView. Default is autoSize */
cardViewList.cardSizeType = .autoSize
    
/** Set max width of CardView in percent(%) of containerView. Default is 100 */
cardViewList.maxWidth = 100
    
/** Set max height of CardView in percent(%) of containerView. Default is 100 */
cardViewList.maxHeight = 100
    
/** Set animation when CardView showing. Default is none */
cardViewList.animationScroll = .none
    
/** Set animation click for CardView. Default is none */
cardViewList.clickAnimation = .none
```

## List of AnimationScroll Types
There are many animation scrolls. You can use them for your CardView list. The animation will start when CardView is visible to the user when scrolling.
- [x] none
- [x] scaleBounce
- [x] transformToRight
- [x] transformToLeft
- [x] transformToBottom
- [x] transformToTop

## List of CardSize Types
There are three CardSize type.
- [x] autoSize : CardView size will generated from library.
- [x] square   : CardView size will be generated to square shape depend by width or height containerView that lower.
- [x] circle   : CardView size will be generated to square circle depend by width or height containerView that lower.

## MIT License
```text
Copyright (c) 2017 Saiful Irham Wicaksana

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
