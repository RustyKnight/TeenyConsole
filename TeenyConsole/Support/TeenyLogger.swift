//
//  TeenyLogger.swift
//  TeenyConsole
//
//  Created by Shane Whitehead on 26/10/18.
//  Copyright © 2018 Kaizen Enterprises. All rights reserved.
//

import Foundation

protocol LogConsumer {
	func log(type: String, message: String, date: Date, file: StaticString, function: StaticString, line: UInt)
}

public class TeenyLogger {
	
	public static let shared: TeenyLogger = TeenyLogger()
	
	public var verbose: String = "📢"
	public var info: String = "💡"
	public var warning: String = "⚠️"
	public var error: String = "🔥"
	public var debug: String = "🐞"
	
	var consumer: LogConsumer?
	
	fileprivate init() {
	}
	
	func log(type: String, message: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		consumer?.log(type: type, message: message, date: date, file: file, function: function, line: line)
	}
	
	func log(verbose: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.verbose, message: verbose, date: date, file: file, function: function, line: line)
	}
	
	func log(verbose: CustomStringConvertible, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.verbose, message: verbose.description, date: date, file: file, function: function, line: line)
	}
	
	func log(info: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.info, message: info, date: date, file: file, function: function, line: line)
	}
	func log(info: CustomStringConvertible, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.info, message: info.description, date: date, file: file, function: function, line: line)
	}
	
	func log(warning: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.warning, message: warning, date: date, file: file, function: function, line: line)
	}
	
	func log(warning: Error, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.warning, message: warning.localizedDescription, date: date, file: file, function: function, line: line)
	}
	
	func log(warning: CustomStringConvertible, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.warning, message: warning.description, date: date, file: file, function: function, line: line)
	}
	
	func log(error: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.error, message: error, date: date, file: file, function: function, line: line)
	}
	
	func log(error: Error, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.error, message: error.localizedDescription, date: date, file: file, function: function, line: line)
	}
	
	func log(error: CustomStringConvertible, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.error, message: error.description, date: date, file: file, function: function, line: line)
	}
	
	func log(debug: String, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.debug, message: debug, date: date, file: file, function: function, line: line)
	}
	
	func log(debug: CustomStringConvertible, date: Date = Date(), file: StaticString, function: StaticString, line: UInt) {
		log(type: self.debug, message: debug.description, date: date, file: file, function: function, line: line)
	}
	
}
