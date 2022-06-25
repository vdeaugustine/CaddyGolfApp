//
//  EditExistingNote.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import SwiftUI
import AlertToast

struct EditExistingNote: View {
    @Binding var passedNote: Note
    @EnvironmentObject var modelData: ModelData
    @FocusState var bodyEditing: Bool
    @State var showToast: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(passedNote.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.01)
                HStack {
                    
                    Spacer()
                    Text(passedNote.date, format: passedNote.date.noteFormat)
                        .foregroundColor(.white)
                }
                

            }.padding()
            ZStack(alignment: .topLeading) {
                TextEditor(text: $passedNote.body)
            }
            .padding()
            .onTapGesture {
                dismissKeyboard()
            }

            Spacer()
        }
        .toast(isPresenting: $showToast, alert: {
            AlertToast(displayMode: .hud, type: .error(.blue), title: "Could not save", subTitle: "Enter a title and a body to save")
        })

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    guard checkNote(passedNote) else {
                        showToast.toggle()
                        // present the alert
                        return
                    }

                    // save
                    modelData.insertNote(passedNote)
                    modelData.bag.reload += 1

                    dismiss()
                } label: {
                    Text("Save")
                }
            }
            
            
        }
    }
}

struct EditExistingNote_Previews: PreviewProvider {
    
    @State static var passed: Note = Note(title: "Something", body: "something more", date: Date())
    static var previews: some View {
        EditExistingNote(passedNote: $passed)
            .preferredColorScheme(.dark)
    }
}
