//
//  QuizViewModel.swift
//  quizeapp
//
//  Created by Chandrakant  Kondke on 15/03/24.
//
import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedOptions: [Set<Int>] = []
    @Published var resultMessage = "" // The message to display when the quiz is completed
    
    private var questionsRepository: QuestionsRepository
    
    init(questionsRepository: QuestionsRepository) {
        self.questionsRepository = questionsRepository
        fetchQuestions()
    }
    
    private func fetchQuestions() {
        questionsRepository.fetchQuestions { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    self.questions = questions
                case .failure(let error):
                    print("Failed to fetch questions: \(error)")
                }
            }
        }
    }
    
    func selectOption(optionIndex: Int) {
        if selectedOptions.count <= currentQuestionIndex {
            selectedOptions.append([])
        }
        
        if selectedOptions[currentQuestionIndex].contains(optionIndex) {
            selectedOptions[currentQuestionIndex].remove(optionIndex)
        } else {
            selectedOptions[currentQuestionIndex].insert(optionIndex)
        }
    }
    
    func navigateToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            // If it's the last question, calculate the result message
            resultMessage = calculateResultMessage()
        }
    }
    
    func navigateToPreviousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    func calculateProgress() -> CGFloat {
        CGFloat(currentQuestionIndex + 1) / CGFloat(questions.count)
    }
    
    private func calculateResultMessage() -> String {
        let correctCount = questions.enumerated().reduce(0) { result, arg1 in
            let (index, question) = arg1
            let selectedOptionsForQuestion = selectedOptions[index]
            let correctOptionsForQuestion = Set(question.correctAnswerIndices)
            return result + (selectedOptionsForQuestion == correctOptionsForQuestion ? 1 : 0)
        }
        
        let percentage = Double(correctCount) / Double(questions.count) * 100
        
        // Generate the result message with percentage truncated to two decimal places
        return String(format: "You answered %d out of %d questions correctly. Your score is %.2f%%.", correctCount, questions.count, percentage)
    }

    
    
    func reset() {
        // Reset the quiz to its initial state
        currentQuestionIndex = 0
        selectedOptions = []
        resultMessage = ""
    }
}
