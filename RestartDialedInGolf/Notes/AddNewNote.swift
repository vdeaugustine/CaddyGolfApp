//
//  AddNewNote.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import AlertToast
import SwiftUI
import AVFAudio

func checkNote(_ theNote: Note) -> Bool {
    return !theNote.body.isEmpty && !theNote.title.isEmpty
}

struct AddNewNote: View {
    @EnvironmentObject var modelData: ModelData
    @State var bodyOfNote: String = "" 
    @State var titleOfNote: String = ""
    @FocusState var bodyEditing: Bool
    @State var textToShow: String = "Tap to begin editing"
    @State var showPlaceholder: Bool = true
    @State var showToast: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                TextField("Note Title", text: $titleOfNote)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text(Date(), format: Date().noteFormat)
                    .foregroundColor(.white)
            }
            .padding()
            ZStack(alignment: .topLeading) {
                TextEditor(text: $bodyOfNote)
                if bodyOfNote.isEmpty {
                    Text("Tap and begin typing")
                        .padding([.leading])
                        .padding([.top], 8)
                }
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
                    let theNewNote = Note(title: titleOfNote, body: bodyOfNote, date: Date())

                    guard checkNote(theNewNote) else {
                        showToast.toggle()
                        // present the alert
                        return
                    }

                    // save
                    modelData.insertNote(theNewNote)
                    modelData.bag.reload += 1
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddNewNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNote()
            .preferredColorScheme(.dark)
    }
}
