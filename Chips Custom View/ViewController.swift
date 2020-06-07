//
//  ViewController.swift
//  Chips Custom View
//
//  Created by ilga yulian putra on 01/06/20.
//  Copyright © 2020 ilga yulian putra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chipsView: ChipsView!
    @IBOutlet weak var chipValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        chipsView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chipsView.addChip(chip: "Chip insert on View Controller")       
    }

    @IBAction func addChip(_ sender: Any) {
        if let value = chipValue.text {
            if value.count > 0 {
                chipsView.addChip(chip: value)
                chipValue.text = ""
            }
        }
    }
}

extension ViewController: ChipsViewDelegate {
    func removeChip(value: String) {
        print("Remove : \(value)")
    }
}

