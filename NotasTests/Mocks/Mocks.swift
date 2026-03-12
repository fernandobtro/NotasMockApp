//
//  Mocks.swift
//  NotasTests
//
//  Created by Fernando Buenrostro on 12/03/26.
//

@testable import Notas
import Foundation

var mockDatabase: [Note] = []

struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }
}

struct fetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Notas.Note] {
        return mockDatabase
    }
}

struct UpdateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}

struct RemoveNoteUseCaseMock: RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase.remove(at: index)
        }
    }
}
