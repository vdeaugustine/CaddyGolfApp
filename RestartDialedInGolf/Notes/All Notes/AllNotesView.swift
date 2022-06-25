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
            if modelData.bag.notes.count > 0 {
                ForEach(modelData.bag.notes.sorted(by: { $0.date > $1.date }), id: \.self) { note in
                        NavigationLink {
                            ViewExistingNote(noteToDisplay: note)
                        } label: {
                            NoteRowView(note: note)
                        }
                    }
                    .onDelete { indexSet in
                        modelData.bag.notes.remove(atOffsets: indexSet)
                        modelData.saveBag()
                    }
                    
                }
                else {
                    Text("Press the button on the top right to add a note")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
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
