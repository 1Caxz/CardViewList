# CardViewList (Swift 4)
Create CardView like Android easier in iOS. Support iOS 8.0 - above!
Now, You can create CardView list like Android in iOS with simple way. This library provides list for horizontal and vertical scroll and with the dynamic control such as tableView in iOS. Easy to understand because of the concept similar to TableViewDelegete. You can create CardView list with your UIViewController or UIView. It's Simple!

<br><br>
<p align="center">
<img width="250" src="https://github.com/icaksama/Weathersama/blob/master/CardViewListExample.gif">&nbsp;&nbsp;&nbsp;
</p>
<br>

# Add Delegete
Add CardViewListDelegete in your UIViewController
```swift
class ViewController: UIViewController, CardViewListDelegete {
```

# Add Method Delegete
Method delegete is optional. But you can add them to your code for detecting some condition for your programs.
```swift
func cardView(willDisplay scrollView: UIScrollView, identifierCards identifier: String) {
    print("Card view will display!")
}

// You can control every single of CardView from here
func cardView(_ scrollView: UIScrollView, willAttachCardView cardView: UIView, identifierCards identifier: String) {
    print("Card view attached!")
}

func cardView(_ scrollView: UIScrollView, didFinishDisplay cardViews: [UIView], identifierCards identifier: String) {
    print("Vertical card view finish display!")
}
```

# Create CardView List with UIViewControler
First, You need to create your UIViewControler as CardView. You can see the demo project.
Make sure run this program inside viewDidAppear for best appearance. "identifier" will let you create more than one CardView list in one page and detect it with the identifier.
```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.cardViewList = CardViewList()
    self.cardViewList.delegete = self
    let cardViews1 = [CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil), CardOneViewController(nibName: "CardOneViewController", bundle: nil)]
    self.cardViewList.generateCardViewList(containerView: cardContainerVertical, cardViews: cardViews1, listType: .vertical, identifier: "verticalCard")
}
```

# Create CardView List with UIView
First, You need to create your Views as CardView. You can see in the demo project.
Make sure run this program inside viewDidAppear for best appearance. "identifier" will let you create more than one CardView list in one page and detect it with the identifier.
```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.cardViewList = CardViewList()
    self.cardViewList.delegete = self
    let cardViews1 = [yourView1, yourView2, yourView3, yourView4]
    self.cardViewList.generateCardViewList(containerView: cardContainerHorizontal, cardViews: cardViews1, listType: .horizontal, identifier: "horizontalCard")
}
```
------------------------------------------------------------------------------------------------------------------------------------
# MIT License

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
