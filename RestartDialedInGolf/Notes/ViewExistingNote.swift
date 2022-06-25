//
//  ViewExistingNote.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import SwiftUI

extension Date {
    var noteFormat: Date.FormatStyle {
        return Date.FormatStyle().day().month().year()
    }
}

struct ViewExistingNote: View {
    @State var noteToDisplay: Note
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(noteToDisplay.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.01)
                HStack {
                    
                    Spacer()
                    Text(noteToDisplay.date, format: noteToDisplay.date.noteFormat)
                        .foregroundColor(.white)
                }
                

            }.padding()
            ZStack(alignment: .topLeading) {
                Text(noteToDisplay.body)
            }
            .padding()
            .onTapGesture {
                dismissKeyboard()
            }

            Spacer()
        }

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditExistingNote(passedNote: $noteToDisplay)
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}

struct ViewExistingNote_Previews: PreviewProvider {
    static var previews: some View {
        ViewExistingNote(noteToDisplay: Note(title: "This is the title of the note", body: "This is the body. It talks about the note", date: Date()))
            .preferredColorScheme(.dark)
    }
}
