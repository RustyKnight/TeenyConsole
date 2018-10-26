//
//  DefaultLogFormatter.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import Foundation
import UIKit

class DefaultLogFormatter: LogFormatter {
	
	public var dateFormatter: DateFormatter

	let darkGrayAttribute = [
		NSAttributedString.Key.foregroundColor: UIColor.darkGray
	]
	
	let grayAttribute = [
		NSAttributedString.Key.foregroundColor: UIColor.gray
	]
	
	let lightGrayAttribute = [
		NSAttributedString.Key.foregroundColor: UIColor.lightGray
	]
	
	let whiteAttribute = [
		NSAttributedString.Key.foregroundColor: UIColor.lightGray
	]
	
	let textAppearance = [
		NSAttributedString.Key.font: UIFont(name: "Menlo", size: 12.0)!
	]
	
	init() {
		dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
	}

	func format(type: String, message: String, date: Date, file: StaticString, function: StaticString, line: UInt) -> NSAttributedString {
		let text = NSMutableAttributedString(string: "")
		text.append("[", attributes: darkGrayAttribute)
		text.append(format(type: type))
		text.append(" ")
		text.append(format(date: date))
		text.append(" ")
		text.append(format(file: "\(file)"))
		text.append(":", attributes: darkGrayAttribute)
		text.append(format(function: "\(function)"))
		text.append("@", attributes: darkGrayAttribute)
		text.append(format(line: line))
		text.append("]: ", attributes: darkGrayAttribute)
		text.append(format(message: message))
		
		text.addAttributes(textAppearance, range: NSRange(location: 0, length: text.length))
		
		return text
	}
	
	func format(type: String) -> NSAttributedString {
		return NSAttributedString(string: type)
	}
	
	func format(file: String) -> NSAttributedString {
		var name = file
		let components = file.description.components(separatedBy: "/")
		if let last = components.last {
			name = last
		}
		
		let text = NSMutableAttributedString(string: name)
		let range = NSRange(location: 0, length: text.length)
		//		print("[\(prefix) \(file):\(function)@\(line)]: \(message)")
		//		print("[\(prefix) \(name):\(function)@\(line)]: \(message)")
		
		text.addAttributes(darkGrayAttribute, range: range)
		
		return text
	}
	
	func format(function: String) -> NSAttributedString {
		let text = NSMutableAttributedString(string: function)
		let range = NSRange(location: 0, length: text.length)
		text.addAttributes(darkGrayAttribute, range: range)
		
		return text
	}
	
	func format(line: UInt) -> NSAttributedString {
		let text = NSMutableAttributedString(string: "\(line)")
		let range = NSRange(location: 0, length: text.length)
		text.addAttributes(darkGrayAttribute, range: range)
		
		return text
	}
	
	func format(message: String) -> NSAttributedString {
		let text = NSMutableAttributedString(string: message)
		let range = NSRange(location: 0, length: text.length)
		text.addAttributes(whiteAttribute, range: range)
		
		return text
	}
	
	func format(date: Date) -> NSAttributedString {
		let text = NSMutableAttributedString(string: dateFormatter.string(from: date))
		let range = NSRange(location: 0, length: text.length)
		text.addAttributes(darkGrayAttribute, range: range)
		
		return text
	}
	
}
