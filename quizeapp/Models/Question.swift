//
//  Question.swift
//  quizeapp
//
//  Created by Chandrakant  Kondke on 15/03/24.
//

import Foundation
struct Question {
    let text: String
    let options: [String]
    let correctAnswerIndices: Set<Int>
}
