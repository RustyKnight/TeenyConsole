//
//  ViewController.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import UIKit

/// This is the top level controller for the console view
class TeenyViewController: UIViewController {
	
	/// the kind of window modes that are supported by TinyConsole
	///
	/// - collapsed: the console is hidden
	/// - expanded: the console is shown
	enum WindowMode {
		case collapsed
		case expanded
	}

	@IBOutlet weak var consoleHeightConstraint: NSLayoutConstraint!

	private let consoleFrameHeight: CGFloat = 120
	// Fraction of window size?
	private let expandedHeight: CGFloat = 140
	
//	private lazy var consoleFrame: CGRect = {
//
//		var consoleFrame = self.view.bounds
//		consoleFrame.size.height -= self.consoleFrameHeight
//
//		return consoleFrame
//	}()
	
	private var consoleWindowMode: WindowMode = .collapsed {
		didSet {
			consoleHeightConstraint.constant = consoleWindowMode == .collapsed ? 0 : self.expandedHeight
			view.setNeedsLayout()
		}
	}

	public var isExpanded: Bool {
		return consoleWindowMode == .expanded
	}
	
	private var consoleViewController: TeenyConsoleViewController?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Hide, as the storyboar default is set to allow easier
		// modification
		consoleHeightConstraint.constant = 0
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? TeenyConsoleViewController, segue.identifier == "Segue.console" {
			consoleViewController = destination
		}
	}
	
	open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		print("Motion begines")
		if (motion == UIEvent.EventSubtype.motionShake) {
			UIView.animate(withDuration: 0.25) {
				self.consoleWindowMode = self.consoleWindowMode == .collapsed ? .expanded : .collapsed
				self.view.layoutIfNeeded()
			}
		}
	}

}

