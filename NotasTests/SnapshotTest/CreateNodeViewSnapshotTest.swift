//
//  CreateNodeViewSnapshotTest.swift
//  NotasTests
//
//  Created by Fernando Buenrostro on 12/03/26.
//

import XCTest
import SnapshotTesting
@testable import Notas

final class CreateNodeViewSnapshotTest: XCTestCase {

    func testCreateNoteView() throws {
        let createNoteView = CreateNoteView(viewModel: .init())
        
        assertSnapshot(of: createNoteView, as: .image)
    }
    
    
    func testCreateNoteViewWithData() {
        let createNoteView = CreateNoteView(viewModel: .init(), title: "Fernando", text: "Aquí ando")
        
        assertSnapshot(of: createNoteView, as: .image)
    }
}

