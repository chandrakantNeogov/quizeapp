//
//  QuizView.swift
//
//  Created by Chandrakant  Kondke on 15/03/24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var isShowingResultDialog = false
    var body: some View {
        VStack {
            ProgressBar(progress: viewModel.calculateProgress())
                .frame(height: 4)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Question \(viewModel.currentQuestionIndex + 1): \(viewModel.questions[viewModel.currentQuestionIndex].text)")
                    .font(.headline)
                
                ForEach(viewModel.questions[viewModel.currentQuestionIndex].options.indices, id: \.self) { optionIndex in
                    Button(action: {
                        viewModel.selectOption(optionIndex: optionIndex)
                    }) {
                        Text(viewModel.questions[viewModel.currentQuestionIndex].options[optionIndex])
                            .foregroundColor(optionStateColor(optionIndex: optionIndex))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(optionBackgroundColor(optionIndex: optionIndex))
                    .cornerRadius(10)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            HStack {
                Button(action: {
                    viewModel.navigateToPreviousQuestion()
                }) {
                    Text("Previous")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(viewModel.currentQuestionIndex == 0)
                
                Spacer()
                
                Button(action: {
                    handleNextOrSubmit()
                }) {
                    Text(viewModel.currentQuestionIndex == viewModel.questions.count - 1 ? "Submit" : "Next")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .alert(isPresented: $isShowingResultDialog) {
                Alert(title: Text("Result"), message: Text(viewModel.resultMessage), dismissButton: .default(Text("Next"), action: {
                    viewModel.reset()
                }))
            }
        }
    }
    
    private func handleNextOrSubmit() {
           if viewModel.currentQuestionIndex == viewModel.questions.count - 1 {
               // Submit quiz or show result
               viewModel.navigateToNextQuestion() // This will calculate the result message and update resultMessage
               isShowingResultDialog = true
           } else {
               viewModel.navigateToNextQuestion()
           }
       }
    
  
    
    private func optionStateColor(optionIndex: Int) -> Color {
        if viewModel.selectedOptions.count > viewModel.currentQuestionIndex {
            if viewModel.selectedOptions[viewModel.currentQuestionIndex].contains(optionIndex) {
                return .white
            }
        }
        
        return .black
    }
    
    private func optionBackgroundColor(optionIndex: Int) -> Color {
        if viewModel.selectedOptions.count > viewModel.currentQuestionIndex {
            if viewModel.selectedOptions[viewModel.currentQuestionIndex].contains(optionIndex) {
                return .blue
            }
        }
        
        return .white
    }
}
