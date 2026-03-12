//
//  ViewModelIntegrationTest.swift
//  NotasTests
//
//  Created by Fernando Buenrostro on 11/03/26.
//

import XCTest
@testable import Notas

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    var sut: ViewModel!
    
    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        
        // When
        let note = sut.notes.first
        
        //Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello 1")
        XCTAssertEqual(note?.text, "text 1")
        XCTAssertEqual(sut.notes.count, 1, "Debería haber una nota en la base de datos")
    }
    
    func testCreateTwoNote() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        
        // When
        let firstNote = sut.notes.first
        let secondNote = sut.notes.last

        
        //Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        XCTAssertNotNil(secondNote)
        XCTAssertEqual(secondNote?.title, "Hello 2")
        XCTAssertEqual(secondNote?.text, "text 2")
        XCTAssertEqual(sut.notes.count, 2, "Debería haber dos nota en la base de datos")
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        // When
        let firstNote = sut.notes.first
        let secondNote = sut.notes.last
        // Then
        XCTAssertEqual(sut.notes.count, 2, "Debe haber dos notas")
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        XCTAssertEqual(secondNote?.title, "Hello 2")
        XCTAssertEqual(secondNote?.text, "text 2")
    }
    
    func testUpdateNote() {
        sut.createNoteWith(title: "Note 1 ", text: "text 1")
        
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        sut.updateNoteWith(identifier: note.identifier, newTitle: "Fernando", newText: "Ahí vas compa")
        sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 1, "Debería haber 1 nota")
        XCTAssertEqual(sut.notes[0].title, "Fernando")
        XCTAssertEqual(sut.notes[0].text, "Ahí vas compa")
    }
    
    func testRemoveNote() {
        sut.createNoteWith(title: "Note 1 ", text: "text 1")
        sut.createNoteWith(title: "Note 2 ", text: "text 2")
        sut.createNoteWith(title: "Note 3 ", text: "text 3")
        
        guard let note = sut.notes.last else {
            XCTFail()
            return
        }
        
        sut.removeNoteWith(identifier: note.identifier)
        XCTAssertEqual(sut.notes.count, 2, "Debería haber 2 notas en la base de datos")
    }
    
    func testRemoveNoteInDatabaseShouldThrowError() {
        sut.removeNoteWith(identifier: UUID())
        
        XCTAssertEqual(sut.notes.count, 0)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, DatabaseError.errorRemove)
    }
}
