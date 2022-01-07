//
//  AllNotesViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import UIKit

class AllNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var models = [(title: String, note: String)]()
    var thisClubNotes: [ClubNote]?
    var mainNotes: [MainNote]?
    var comingFrom = ""

    @IBOutlet var notesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapNewNote))

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if comingFrom == "home" {
            mainNotes = getAllMainNotes()
            print("Viewwill appear main notes")
            
        } else if comingFrom == "club" {
            thisClubNotes = getAllClubNotes()
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

        newNoteVC.comingFrom = self.comingFrom
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
        if comingFrom == "home" {
            guard let mainNotes = mainNotes else {
                return 0
            }
            return mainNotes.count
        } else if comingFrom == "club" {
            guard let thisClubNotes = thisClubNotes else {
                return 0
            }
            return thisClubNotes.count

        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
//        let currentNote = currentClubNotes[indexPath.row]
//        let currentNote = models[indexPath.row]
        if comingFrom == "home" {
            print("coming from home")
            if let mainNotes = mainNotes {
                print("in mainnotes")
                let currentNote = mainNotes[indexPath.row]
                cell.noteTitle.text = currentNote.title
                cell.noteContentPreview.text = currentNote.subTitle
            }
        } else if comingFrom == "club" {
            print("in club notes")
            if let thisClubNotes = thisClubNotes {
                let currentNote = thisClubNotes[indexPath.row]
                cell.noteTitle.text = currentNote.title
                cell.noteContentPreview.text = currentNote.subTitle
            }
        } else {
            print("problem in creating cell")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NoteEntryViewController") as? NoteEntryViewController else {
            print("ERROR WITH INSTANTIATION")
            return
        }
        vc.hasContentAlready = true
        vc.comingFrom = self.comingFrom
        navigationController?.pushViewController(vc, animated: true)
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
}
