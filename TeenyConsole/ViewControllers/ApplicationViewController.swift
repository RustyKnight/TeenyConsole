//
//  ApplicationViewController.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController {

	@IBAction func makeItLog(_ sender: Any) {
		TeenyLogger.shared.log(debug: "This is a message",
													 file: #file,
													 function: #function,
													 line: #line)
	}
}
