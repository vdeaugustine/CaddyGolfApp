//
//  AddNewNote.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import AlertToast
import AVFAudio
import SwiftUI

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
        VStack(alignment: .leading) {
            HStack {
                TextField("Note Title", text: $titleOfNote)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showPlaceholder = true
                    }

            }.padding(10)

            ZStack {
                TextEditor(text: $bodyOfNote)
                    .padding(.leading)
                if showPlaceholder && bodyOfNote.isEmpty {
                    Text("Tap anywhere to begin editing")
                }
            }

            .onTapGesture {
                showPlaceholder = false
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
