//
//  TeenyConsoleViewController.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import UIKit

class TeenyConsoleViewController: UIViewController {
	
	@IBOutlet weak var consoleTextView: UITextView!
	
	var logFormatter: LogFormatter = DefaultLogFormatter()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		TeenyLogger.shared.consumer = self
		
		consoleTextView.backgroundColor = UIColor.black
		consoleTextView.isEditable = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}

	public func scrollToBottom() {
		if consoleTextView.bounds.height < consoleTextView.contentSize.height {
			consoleTextView.layoutManager.ensureLayout(for: consoleTextView.textContainer)
			let offset = CGPoint(x: 0, y: (consoleTextView.contentSize.height - consoleTextView.frame.size.height))
			consoleTextView.setContentOffset(offset, animated: true)
		}
	}
	
}

extension TeenyConsoleViewController: LogConsumer {
	
	func log(type: String, message: String, date: Date, file: StaticString, function: StaticString, line: UInt) {
		append(message: logFormatter.format(type: type, message: message, date: date, file: file, function: function, line: line))
	}
	
	func append(message: NSAttributedString) {
		DispatchQueue.main.async {
			let newText = NSMutableAttributedString(attributedString: self.consoleTextView.attributedText)
			newText.append("\n")
			newText.append(message)
			self.consoleTextView.attributedText = newText
			self.scrollToBottom()
		}
	}
	
}
