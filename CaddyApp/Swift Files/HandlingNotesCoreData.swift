//
//  HandlingNotesCoreData.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import CoreData
import Foundation
import UIKit

var clubNotes = [ClubNote]()
var mainNotes = [MainNote]()
let mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// MARK: - FOR CLUBS


func getAllClubNotes(_ clubName: AllClubNames) -> [ClubNote] {
    do {
        let request = ClubNote.fetchRequest() as NSFetchRequest<ClubNote>

        let pred = NSPredicate(format: "clubName CONTAINS %@", clubName.rawValue)
        request.predicate = pred
        // Set filtering and sorting on the request
        clubNotes = try mainContext.fetch(request)
        return clubNotes
    } catch {}
    return [ClubNote]()
}
func getAllClubNotes(_ clubName: String) -> [ClubNote] {
    do {
        let request = ClubNote.fetchRequest() as NSFetchRequest<ClubNote>

        let pred = NSPredicate(format: "clubName CONTAINS %@", clubName)
        request.predicate = pred
        // Set filtering and sorting on the request
        clubNotes = try mainContext.fetch(request)
        return clubNotes
    } catch {}
    return [ClubNote]()
}

func createClubNote(title: String, subtitle: String, type: AllClubNames) {
    let newItem = ClubNote(context: mainContext)
    newItem.title = title
    newItem.subTitle = subtitle
    newItem.clubName = type.rawValue
    do {
        try mainContext.save()
        _ = getAllClubNotes(type)
    } catch {}
}

func deleteClubNote(note: ClubNote) {
    mainContext.delete(note)
    do {
        try mainContext.save()

    } catch {
        print("PROBLEM DELETING NOTE")
    }
}

func updateClubNote(note: ClubNote, newTitle: String, newSubtitle: String, type: AllClubNames) {
    note.title = newTitle
    note.subTitle = newSubtitle
    do {
        try mainContext.save()
    } catch {}
}

// MARK: - FOR MAIN

func getAllMainNotes() -> [MainNote] {
    do {
        print("getting main notes")
        mainNotes = try mainContext.fetch(MainNote.fetchRequest())
        print("main notes gotten")
        return mainNotes
    } catch {
        print("problem getting main notes")
    }
    return [MainNote]()
}

func createMainNote(title: String, content: String) {
    let newItem = MainNote(context: mainContext)
    newItem.title = title
    newItem.subTitle = content
    do {
        try mainContext.save()
        _ = getAllMainNotes()
    } catch {
        print("problem saving main note")
    }
}

func deleteMainNote(note: MainNote) {
    mainContext.delete(note)
    do {
        try mainContext.save()

    } catch {
        print("PROBLEM DELETING NOTE")
    }
}

func updateMainNote(note: MainNote, newTitle: String, newContent: String) {
    note.title = newTitle
    note.subTitle = newContent
    do {
        try mainContext.save()
    } catch {
        fatalError("FAIL TO UDPATE MAIN NOTE")
    }
}
