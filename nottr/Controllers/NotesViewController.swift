//
//  NotesViewController.swift
//  notey
//
//  Created by Pavel Romanishkin on 02.04.21.
//

import UIKit

class NotesViewController: UITableViewController {
    
    var coreDataManager = CoreDataManager()
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = coreDataManager.loadData()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notes = coreDataManager.loadData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        cell.textLabel?.text = notes[indexPath.row].title

        return cell
    }

    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            coreDataManager.context.delete(notes[indexPath.row])
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        coreDataManager.saveData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditNote") {
            if let destinationVC = segue.destination as? NoteEditViewController {
                let currentNote = notes[tableView.indexPathForSelectedRow!.row]
                destinationVC.note = currentNote
            }
        }
    }

    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddNote", sender: self)
    }
}
