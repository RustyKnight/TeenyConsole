//
//  LogFormatter.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import Foundation

protocol LogFormatter {
	func format(type: String, message: String, date: Date, file: StaticString, function: StaticString, line: UInt) -> NSAttributedString
}
