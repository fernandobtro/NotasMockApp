//
//  ViewModelTests.swift
//  NotasTests
//
//  Created by Fernando Buenrostro on 11/03/26.
//

import XCTest
@testable import Notas

final class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel(createNoteUseCase: CreateNoteUseCaseMock() , fetchAllNotesUseCase: fetchAllNotesUseCaseMock(), updateNoteUseCase: UpdateNoteUseCaseMock(), removeNoteUseCase: RemoveNoteUseCaseMock())
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockDatabase = []
    }
    
    func testCreateNode() {
        // Given
        let title = "Test title"
        let text = "Test Text"
        
        // When
        viewModel.createNoteWith(title: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
    }
    
    func testCreateThreeNotes() {
        let title1 = "Test title 1"
        let text1 = "Test Text 1"
        let title2 = "Test title 2"
        let text2 = "Test Text 2"
        let title3 = "Test title 3"
        let text3 = "Test Text 3"
        
        viewModel.createNoteWith(title: title1, text: text1)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title1)
        XCTAssertEqual(viewModel.notes.first?.text, text1)
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    func testUpdateNote() {
        // Given
        let title = "Test title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        let newTitle = "New Title"
        let newText = "New Text"
        
        // When
        if let id = viewModel.notes.first?.identifier {
            viewModel.updateNoteWith(identifier: id, newTitle: newTitle, newText: newText)
            // Then
            
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
            
        } else {
            XCTFail("No NOTE WAS CREATED")
        }

    }
    
    func testRemoveNote() {
        // Given
        let title = "Test title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        if let id = viewModel.notes.first?.identifier {
            // When
            
            viewModel.removeNoteWith(identifier: id)
            
            // Then
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail("No note was created")
        }
    }
}
