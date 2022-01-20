//
//  AllNotesViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import UIKit

// TODO: - Add some padding to the all notes table view. right now the text of the notes looks like it is too close to the edge of the screen

class AllNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var models = [(title: String, note: String)]()
    var thisClubNotes: [ClubNote]?
    var mainNotes: [MainNote]?
    var comingFrom: String = ""
    var atLeastOneNoteExists = false

    @IBOutlet var notesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapNewNote))
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillAppear(_ animated: Bool) {
        if comingFrom == "home" {
            mainNotes = getAllMainNotes()
            title = "General Notes"
            print("Viewwill appear main notes")

        } else if comingFrom == "club" {
            thisClubNotes = getAllClubNotes(currentClubTypeAsEnum())
            title = "\(currentClub.name.capitalized) Notes"
            print("view will appear club notes")
            print(clubNotes)
        }
        notesTableView.reloadData()
    }

    @objc func didTapNewNote() {
        let newNoteVC = storyboard?.instantiateViewController(withIdentifier: "NoteEntryViewController") as! NoteEntryViewController
        newNoteVC.title = "New Note"
        newNoteVC.completion = { noteTitle, noteContent in
            self.navigationController?.popToViewController(self, animated: true)
            self.models.append((noteTitle, noteContent))
            self.notesTableView.reloadData()
        }

        newNoteVC.comingFrom = comingFrom
        newNoteVC.hasContentAlready = false
        navigationController?.pushViewController(newNoteVC, animated: true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currentClubNotes.count

        var numOfCells = 0
        if comingFrom == "home" {
            if let mainNotes = mainNotes {
                numOfCells = mainNotes.count
            }

        } else if comingFrom == "club" {
            if let thisClubNotes = thisClubNotes {
                numOfCells = thisClubNotes.count
            }
            
        } else {
            return 0
        }

        if numOfCells > 0 {
            atLeastOneNoteExists = true
        }

        if !atLeastOneNoteExists {
            return 1
        }

        return numOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let nextVC: UIViewController

        if !atLeastOneNoteExists {
            cell.noteTitle.text = "No notes yet"
            cell.noteContentPreview.text = "Tap this cell or the plus button in the top right corner to create new note"
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteEntryViewController") as? NoteEntryViewController else {
                print("ERROR WITH INSTANTIATION")
                fatalError()
            }
            nextVC = vc
            
        }
        else {
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewSingleNoteViewController") as? ViewSingleNoteViewController else {
                print("ERROR WITH INSTANTIATION")
                fatalError()
            }
            
            nextVC = vc
            if comingFrom == "home" {
                print("coming from home")
                if let mainNotes = mainNotes {
                    print("in mainnotes")
                    let currentNote = mainNotes[indexPath.row]
                    cell.noteTitle.text = currentNote.title
                    cell.noteContentPreview.text = currentNote.subTitle
                    vc.noteText = currentNote.subTitle
                    vc.titleText = currentNote.title
                }
            } else if comingFrom == "club" {
                print("in club notes")
                if let thisClubNotes = thisClubNotes {
                    let currentNote = thisClubNotes[indexPath.row]
                    cell.noteTitle.text = currentNote.title
                    cell.noteContentPreview.text = currentNote.subTitle
                    vc.noteText = currentNote.subTitle
                    vc.titleText = currentNote.title
                }
            } else {
                print("problem in creating cell")
            }
            
            
        }
        
        cell.pageToGoToIfTapped = nextVC
        cell.navigationController = navigationController!

        return cell

        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if !atLeastOneNoteExists {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteEntryViewController") as? NoteEntryViewController else {
                print("ERROR WITH INSTANTIATION")
                fatalError()
            }
            if let navController = navigationController {
                navController.pushViewController(vc, animated: true)
            }
        } else {
            
            print("tapped on note")
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewSingleNoteViewController") as? ViewSingleNoteViewController else {
                print("ERROR WITH INSTANTIATION")
                return
            }
    //        vc.hasContentAlready = true
    //        vc.comingFrom = comingFrom
            if let thisClubNotes = thisClubNotes {
                let currentNote = thisClubNotes[indexPath.row]
                vc.titleText = currentNote.title
                vc.noteText = currentNote.subTitle
                vc.thisClubNote = currentNote
                if vc.thisClubNote != nil {
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    fatalError()
                }
            }
            if let mainNotes = mainNotes {
                let currentNote = mainNotes[indexPath.row]
                vc.titleText = currentNote.title
                vc.noteText = currentNote.subTitle
                vc.thisMainNote = currentNote
                vc.typeOfNote = "main"
                if vc.thisMainNote != nil {
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    fatalError()
                }
            }

            
            
        }
        
        
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Remove it from the data model

            if comingFrom == "home" {
                guard mainNotes != nil else {
                    print("mainnotesnil")
                    return
                }
                let currentNote = mainNotes![indexPath.row]
                mainNotes!.remove(at: indexPath.row)
                deleteMainNote(note: currentNote)

            } else if comingFrom == "club" {
                guard thisClubNotes != nil else {
                    print("clubnotesnill")
                    return
                }
                let currentNote = thisClubNotes![indexPath.row]
                thisClubNotes!.remove(at: indexPath.row)
                deleteClubNote(note: currentNote)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return atLeastOneNoteExists
    }
}
