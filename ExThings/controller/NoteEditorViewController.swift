//
//  NoteEditorViewController.swift
//  ExThings
//
//  Created by Stephen Downs on 2018-10-13.
//  Copyright © 2018 plasticbrain. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController, UITextViewDelegate, Storyboarded {
    
    weak var delegate: NoteEditorViewControllerDelegate?
    
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
    
    deinit {
        delegate?.removed(self)
    }

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

extension NoteEditorViewController: TextConsumer {}

protocol NoteEditorViewControllerDelegate: AnyObject {
    func removed(_ noteEditorViewController: NoteEditorViewController)
}
