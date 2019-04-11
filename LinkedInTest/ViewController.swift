//
//  ViewController.swift
//  LinkedInTest
//
//  Created by JP LaFond on 4/11/19.
//  Copyright © 2019 Jp LaFond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dateFormatter = DateFormatter()

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func loginPressed(sender: UIButton) {
        log("\(#function)")
    }

    private var errorText = String()

    private func log(_ comment: String = "", at now: Date = Date()) {
        let nowString = dateFormatter.string(from: now)
        errorText = "<\(comment)>[\(nowString)]\n" + errorText
        errorLabel.text = errorText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        log("\(#function)")
    }


}

