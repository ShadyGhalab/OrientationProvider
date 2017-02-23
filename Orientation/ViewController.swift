//
//  ViewController.swift
//  Orientation
//
//  Created by Shady Ghalab on 23/02/2017.
//  Copyright © 2017 Shady Ghalab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(size)
        let op = OrientionProvider()
        print(op.orientation())
        
    }

}
