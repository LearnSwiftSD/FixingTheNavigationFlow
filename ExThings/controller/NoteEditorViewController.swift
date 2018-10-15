//
//  NoteEditorViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-13.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var noteTextView: UITextView! {
        didSet {
            noteTextView.delegate = self
            updateViewFromData()
        }
    }
    
    // MARK: - Model
    
    var text: String? {
        didSet {
            updateViewFromData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewFromData()
    }
    
    // MARK: - Interaction - Text view
    
    func textViewDidChange(_ textView: UITextView) {
        text = textView.text
    }
    
    // MARK: - Navigation
    
    @IBAction func selectCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Rendering
    
    private func updateViewFromData() {
        noteTextView?.text = text ?? ""
    }
    
    

}
