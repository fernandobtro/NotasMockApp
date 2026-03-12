//
//  NotasTests.swift
//  NotasTests
//
//  Created by Fernando Buenrostro on 11/03/26.
//

import XCTest
@testable import Notas

final class NoteTest: XCTestCase {
    func testNoteInitialization() {
        // Given or Arrenge
        let title = "Test title"
        let text = "Test Text"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createdAt, date)
    }
    
    func testNoteEmptyText() {
        let title = "Test Title"
        let date = Date()
        
        let note = Note(title: title, text: nil, createdAt: date)
        
        XCTAssertEqual(note.getText, "")
        
    }

}
