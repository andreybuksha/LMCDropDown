//
//  ViewController.swift
//  DropDownExample
//
//  Created by Andrey Buksha on 23.10.2019.
//  Copyright © 2019 Andrey Buksha. All rights reserved.
//

import UIKit
import LMCDropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButtonTapped(_ sender: UIButton) {
        let first = ListData(title: "John Doe", subtitle: "Accountant")
        let forth = ListData(title: "Hideo Kodjima", subtitle: "Genius")

        let data = [
            first,
            forth
        ]
        let dropDownVC = ListDropDownController(with: self, anchorView: button)
        dropDownVC.presentMode = .init(verticalPosition: .top, widthMode: .equalToAnchor)

        dropDownVC.dropDownRows = data

        ListDropDownView.appearance().listBackgroundColor = .red

        dropDownVC.show(on: view, animated: true)
    }
    
}

struct ListData: ListDropDownCellPresenting {
    
    var title: String
    var subtitle: String?
    
}
