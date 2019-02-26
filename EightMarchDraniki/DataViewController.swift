//
//  DataViewController.swift
//  EightMarchDraniki
//
//  Created by Dmitry Afanasyev on 2/25/19.
//  Copyright © 2019 Dmitry Afanasyev. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var questionLabel: UILabel?
    @IBOutlet weak var answerTextField: UITextField?
    @IBOutlet weak var actionButton: UIButton?
    @IBOutlet weak var backgroundImage: UIImageView?
    
    var dataObject = DataSource()
    var onNextPressed: ((Int) -> Void)?
    var closeKeyboardGestureRecognizer: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel?.isHidden = true
        actionButton?.isHidden = true
        answerTextField?.isHidden = true
        
        questionLabel?.text = dataObject.question
        answerTextField?.delegate = self
        actionButton?.isEnabled = false
        actionButton?.backgroundColor = UIColor.lightGray
        answerTextField?.returnKeyType = .next
        
        backgroundImage?.image = UIImage(named: dataObject.imageSource)
        
        closeKeyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureDidTap))
        view.addGestureRecognizer(closeKeyboardGestureRecognizer!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        questionLabel?.isHidden = false
        questionLabel?.layer.opacity = 0
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.questionLabel?.layer.opacity = 1
        }) { _ in
            self.actionButton?.isHidden = false
            self.answerTextField?.isHidden = false
            self.actionButton?.layer.opacity = 0
            self.answerTextField?.layer.opacity = 0
            UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseOut, animations: {
                self.actionButton?.layer.opacity = 1
                self.answerTextField?.layer.opacity = 1
            }, completion: { _ in })
        }
    }
    
    @objc func gestureDidTap() {
        view.endEditing(true)
    }
    
    func validateAnswer(answer: String) {
        let isValid = dataObject.validate(answer: answer.trimmingCharacters(in: .whitespaces))
        actionButton?.isEnabled = isValid
        actionButton?.backgroundColor = isValid ? UIColor.blue : UIColor.lightGray
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if
            let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            validateAnswer(answer: updatedText)
        }
        return true
    }
    
    @IBAction func actionButtonPressed() {
        onNextPressed?(dataObject.id)
    }

}

