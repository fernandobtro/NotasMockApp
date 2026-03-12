//
//  CreateNoteView.swift
//  Notas
//
//  Created by Fernando Buenrostro on 11/03/26.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("Texto"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                        .foregroundStyle(.red)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }
                ToolbarItem(placement:.topBarTrailing) {
                    Button {
                       viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("Crear Nota")
                            .bold()
                    }
                }
            }
            .navigationTitle(Text("Nueva Nota"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
