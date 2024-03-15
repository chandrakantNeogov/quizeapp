//
//  QuestionsRepository.swift
//  quizeapp
//
//  Created by Chandrakant  Kondke on 15/03/24.
//

import Foundation

protocol QuestionsRepository {
    func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> Void)
}

import Foundation

// Define a concrete implementation of the QuestionsRepository protocol
class QuestionsRepositoryImpl: QuestionsRepository {
    // Implement the fetchQuestions method
    func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {
        // Simulated asynchronous fetching of questions
        DispatchQueue.global().async {
            // Simulate fetching questions from a remote server or a database
            let questions = [
                Question(text: "What is the capital of France?", options: ["London", "Paris", "Berlin", "Madrid"], correctAnswerIndices: [1]),
                Question(text: "Which of the following is a mammal?", options: ["Fish", "Bird", "Dog", "Snake"], correctAnswerIndices: [2]),
                Question(text: "Which planet is known as the Red Planet?", options: ["Mars", "Venus", "Jupiter", "Mercury"], correctAnswerIndices: [0])
                // Add more questions as needed
            ]
            
            // Call the completion handler with the fetched questions
            completion(.success(questions))
        }
    }
}
