//
//  UpdateNoteView.swift
//  Notas
//
//  Created by Fernando Buenrostro on 11/03/26.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let identifier: UUID
    
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("Texto"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                }
            }
            Button(action: {
                viewModel.removeNoteWith(identifier: identifier)
                dismiss()
            }, label:{
                Text("Eliminar nota")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem(placement:.topBarTrailing) {
                Button {
                   viewModel.updateNoteWith(identifier: identifier, newTitle: title, newText: text)
                    dismiss()
                } label: {
                    Text("Crear Nota")
                        .bold()
                }
            }
        }
        .navigationTitle(Text("Modificar Nota"))
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), identifier: .init(), title: "Prueba para editar", text: "Esta es una prueba para la edición de notas.")
    }
}
