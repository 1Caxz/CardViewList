//
//  CardTwoViewController.swift
//  CardViewListDemo
//
//  Created by Saiful I. Wicaksana on 11/13/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit

class CardTwoViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imgProfile.layer.cornerRadius = imgProfile.bounds.width / 2
        imgProfile.clipsToBounds = true
        lblSummary.layer.cornerRadius = 12
        lblSummary.clipsToBounds = true
        btnDetail.layer.cornerRadius = 12
    }
    
    @IBAction func btnDetailTouchUp(_ sender: Any) {
        print("Touch up")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
