//
//  TeenyConsoleViewController.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import UIKit

protocol PanDelegate {
	func console(_ console: TeenyConsoleViewController, pannedBy: CGPoint)
}

class TeenyConsoleViewController: UIViewController {
	
	@IBOutlet weak var consoleTextView: UITextView!
	@IBOutlet weak var headerView: UIView!

	@IBOutlet weak var notchImageView: UIImageView!

	@IBOutlet weak var shareButton: UIButton!
	@IBOutlet weak var clearButton: UIButton!
	
	var logFormatter: LogFormatter = DefaultLogFormatter()
	var panDelegate: PanDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		TeenyLogger.shared.consumer = self
		
		//consoleTextView.backgroundColor = UIColor.black
		consoleTextView.isEditable = false
		
		notchImageView.image = TeenyStyleKit.imageOfNotch(imageSize: CGSize(width: 72, height: 6), notchBackground: UIColor.white, strokeWidth: 6)
		shareButton.setImage(TeenyStyleKit.imageOfShare(imageSize: CGSize(width: 22, height: 22), iconFillColor: UIColor.white), for: [])
		clearButton.setImage(TeenyStyleKit.imageOfClear(imageSize: CGSize(width: 22, height: 22), iconFillColor: UIColor.white), for: [])

		shareButton.imageView?.contentMode = .scaleAspectFit
		clearButton.imageView?.contentMode = .scaleAspectFit
		
		view.layer.cornerRadius = 20
		
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
		headerView.addGestureRecognizer(panGesture)
		headerView.isUserInteractionEnabled = true
		panGesture.delegate = self
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
	
	@objc func pan(gesture: UIPanGestureRecognizer) {
		guard gesture.state == .began || gesture.state == .changed else {
			return
		}
		let translation = gesture.translation(in: self.view)
		print("translation = \(translation)")
		
//		let center = gesture.view!.center
//		gesture.view!.convert(center, to: self.view)

		panDelegate?.console(self, pannedBy: translation)
		gesture.setTranslation(CGPoint(x: 0, y: 0), in: headerView)
	}

	public func scrollToBottom() {
		if consoleTextView.bounds.height < consoleTextView.contentSize.height {
			consoleTextView.layoutManager.ensureLayout(for: consoleTextView.textContainer)
			let offset = CGPoint(x: 0, y: (consoleTextView.contentSize.height - consoleTextView.frame.size.height))
			consoleTextView.setContentOffset(offset, animated: true)
		}
	}
	
	@IBAction func share(_ sender: Any) {
	}
	
	@IBAction func clear(_ sender: Any) {
		consoleTextView.text = nil
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

extension TeenyConsoleViewController: UIGestureRecognizerDelegate {
	
}
