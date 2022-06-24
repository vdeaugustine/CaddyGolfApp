//
//  AllNotesView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/20/22.
//

import SwiftUI

struct AllNotesView: View {
    @EnvironmentObject var modelData: ModelData
    @State var bag: Bag? = nil
    var body: some View {
        List {
            if var thisBag = bag {
                if thisBag.notes.count > 0 {
                    ForEach(Array(thisBag.notes).sorted(by: { $0.date > $1.date }), id: \.self) { note in
                        NavigationLink {
                            ViewExistingNote(noteToDisplay: note)
                        } label: {
                            NoteRowView(note: note)
                        }
                    }
                    .onDelete { indexSet in
                        var arr = Array(thisBag.notes).sorted(by: { $0.date > $1.date })
                        arr.remove(atOffsets: indexSet)
                        thisBag.notes = Set(arr)
                        modelData.bag = thisBag
                        modelData.saveBag()
                    }
                    
                }
                else {
                    Text("Press the button on the top right to add a note")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
                }
            } else {
                Text("NO NOTES")
            }
        }
        .onAppear {
            bag = modelData.loadBag()
        }

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddNewNote()
                } label: {
                    Label("Add New Note", systemImage: "plus")
                }
            }
        }
    }
}

struct AllNotesView_Previews: PreviewProvider {
    static var previews: some View {
        AllNotesView()
            .environmentObject(ModelData(forType: .preview))
    }
}
