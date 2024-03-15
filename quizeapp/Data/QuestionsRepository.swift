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

class QuestionsRepositoryImpl: QuestionsRepository {
    
    func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            completion(.failure(NSError(domain: "App", code: 404, userInfo: [NSLocalizedDescriptionKey: "questions.json not found"])))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Question].self, from: data)
            let shuffledQuestions = questions.shuffled()
            let selectedQuestions = Array(shuffledQuestions.prefix(10))
            completion(.success(selectedQuestions))
        } catch {
            completion(.failure(error))
        }
    }
}


