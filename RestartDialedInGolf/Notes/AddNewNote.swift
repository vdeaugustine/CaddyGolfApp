//
//  AddNewNote.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import SwiftUI

struct AddNewNote: View {
    @EnvironmentObject var modelData: ModelData
    @State var bodyOfNote: String = "" {
        didSet {
            print(bodyOfNote)
        }
    }
    @State var titleOfNote: String = ""
    @FocusState var bodyEditing: Bool
    @State var textToShow: String = "Tap to begin editing"
    @State var showPlaceholder: Bool = true
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                TextField("Note Title", text: $titleOfNote)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Note date")
                    .foregroundColor(.white)
            }
            .padding()
            ZStack(alignment: .topLeading) {
                TextEditor(text: $bodyOfNote)
                if bodyOfNote.isEmpty {
                    Text("Tap to begin editing")
                        .padding([.leading, .top])
                }
            }
            .padding()
            .onTapGesture {
                dismissKeyboard()
            }
              
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // save
                    modelData.insertNote(Note(title: titleOfNote, body: bodyOfNote, date: Date()))
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
