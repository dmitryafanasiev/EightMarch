//
//  WelcomeViewController.swift
//  EightMarchDraniki
//
//  Created by Dmitry Afanasyev on 2/25/19.
//  Copyright © 2019 Dmitry Afanasyev. All rights reserved.
//

import Foundation
import UIKit

struct Tip {
    var text: String = ""
    var delay: TimeInterval = 0.0
    
    init(text: String, delay: TimeInterval) {
        self.text = text
        self.delay = delay
    }
}

class WelcomeViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var wtfButton: UIButton!
    
    var dataSource: [Tip] = [
        Tip(text: "Дорогие девушки!", delay: 2.5),
        Tip(text: "\nМы хотели поздравить вас с 8 марта и вручить подарки", delay: 2.5),
        Tip(text: "\n\nНо", delay: 1),
        Tip(text: "Подарки были взяты в заложники...", delay: 3),
        Tip(text: "\nПохитители вышли на связь и озвучили свои требования:", delay: 3),
        Tip(text: "\n\nЧтобы освободить подарки, девушкам нужно правильно ответить на ряд вопросов", delay: 4),
        Tip(text: "Итак...", delay: 2.5),
        Tip(text: "Давайте начнем?", delay: 1.5),
    ]
    var currentTipIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        startButton.isHidden = true
        infoLabel.layer.opacity = 0
    }
    
    @IBAction func startButtonPressed() {
        performSegue(withIdentifier: "ShowQuestions", sender: nil)
    }
    
    @IBAction func wtfButtonPressed() {
        startTheFlow()
    }
    
    func startTheFlow() {
        UIView.animate(withDuration: 0.45, animations: {
            self.wtfButton.layer.opacity = 0
        }) { _ in
            self.wtfButton.isHidden = true
        }
        perform(#selector(showNextTip), with: dataSource[currentTipIndex], afterDelay: 0.5)
    }
    
    @objc func showNextTip() {
        
        infoLabel.text = dataSource[currentTipIndex].text
        let delay = dataSource[currentTipIndex].delay
        let isTheLastElement = currentTipIndex == dataSource.count - 1
        
        UIView.animate(withDuration: 0.25, animations: {
            self.infoLabel.layer.opacity = 1
        }) { completed in
            if completed {
                if !isTheLastElement {
                    UIView.animate(withDuration: 0.25, delay: delay - 0.6, animations: {
                        self.infoLabel.layer.opacity = 0
                    })
                }
            } else {
                self.infoLabel.layer.opacity = isTheLastElement ? 1 : 0
            }
        }
        
        if !isTheLastElement {
            perform(#selector(showNextTip), with: dataSource[currentTipIndex], afterDelay: dataSource[currentTipIndex].delay)
        } else {
            startButton.isHidden = false
            startButton.layer.opacity = 0
            UIView.animate(withDuration: 1.5) {
                self.startButton.layer.opacity = 1
            }
        }
        
        currentTipIndex += 1
    }
}
