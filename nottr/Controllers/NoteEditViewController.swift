//
//  NoteEditViewController.swift
//  notey
//
//  Created by Pavel Romanishkin on 02.04.21.
//

import UIKit

class NoteEditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextField: UITextField!
    
    var note: Note?
    var coreDataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentNote = note {
            titleTextField.text = currentNote.title
            textTextField.text = currentNote.text
        }
    }

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        if note != nil {
            note!.title = titleTextField.text
            note!.text = textTextField.text
        } else {
            let newNote = Note(context: coreDataManager.context)
            newNote.title = titleTextField.text
            newNote.text = textTextField.text
        }
        coreDataManager.saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
