//
//  NoteRowView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import SwiftUI

struct NoteRowView: View {
    var note: Note
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title)
                    .font(.title2)
                Spacer()
            }
            .padding(.leading, 7)
            HStack(alignment: .top) {
                Text(note.body)
                    .font(.subheadline)
                    .minimumScaleFactor(0.75)
                    .padding(.leading, 25)
                    .opacity(0.74)
                    
                Spacer()

                VStack {
                    Spacer()
                    Text(note.date, format: note.date.noteFormat)
                        .font(.caption2)
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
                .padding([.trailing,.bottom], 5)
            }
        }
        
        .foregroundColor(.white)
    }
}

struct NoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoteRowView(note: Note(title: "This is the title", body: "This is the body", date: Date()))
            .previewLayout(.fixed(width: 400, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
            .preferredColorScheme(.dark)
    }
}
