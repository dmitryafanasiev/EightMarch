//
//  DataSource.swift
//  EightMarchDraniki
//
//  Created by Dmitry Afanasyev on 2/25/19.
//  Copyright © 2019 Dmitry Afanasyev. All rights reserved.
//

import Foundation

struct DataSource {
    var question: String = ""
    var answers: [String] = []
    var id: Int = 0
    var imageSource: String = ""
    
    init() {
        self.question = ""
        self.answers = []
        self.id = 0
        self.imageSource = ""
    }
    
    init(id: Int, question: String, answers: [String]) {
        self.id = id
        self.question = question
        self.answers = answers
        self.imageSource = "Background\(id)"
    }
    
    func validate(answer: String) -> Bool {
        let result = answers.first(where: { $0.lowercased() == answer.lowercased()})
        return result != nil
    }
}

class SharedSource {
    static let shared = SharedSource()
    
    let data: [DataSource]
    
    init() {
        data = [
            DataSource(id: 0, question: "Какой цветок используют для гадания?", answers: ["Ромашка", "ромашку"]),
            DataSource(id: 1, question: "Какой алкогольный напиток напоминает своим названием о женском празднике?", answers: ["мартини"]),
            DataSource(id: 2, question: "Лучший в истории ISSoft проект", answers: ["видеолоджи", "videology"]),
            DataSource(id: 3, question: "В чем Шапокляк носила крысу?", answers: ["ридикюль"]),
            DataSource(id: 4, question: "Надо тестить или нет - нелегко найти ответ; он источник всех забот, догадались?", answers: ["azure prod", "azureprod", "ажурпрод", "азурпрод", "азур прод", "ажур прод"]),
        ]
    }
}
