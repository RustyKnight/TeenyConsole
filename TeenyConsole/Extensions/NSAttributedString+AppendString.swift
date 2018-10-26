//
//  NSAttributedString+AppendString.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
	func append(_ text: String) {
		append(NSAttributedString(string: text))
	}
	
	func append(_ text: String, attributes: [NSAttributedString.Key: Any]) {
		let aString = NSMutableAttributedString(string: text)
		let range = NSRange(location: 0, length: aString.length)
		aString.addAttributes(attributes, range: range)
		append(aString)
	}
	
}
