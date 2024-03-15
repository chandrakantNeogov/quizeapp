//
//  ContentView.swift
//  quizeapp
//
//  Created by Chandrakant  Kondke on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isQuizViewPresented = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Quiz App")
                    .font(.title)
                    .padding()
                
                NavigationLink(
                    destination: QuizView(viewModel: QuizViewModel(questionsRepository: QuestionsRepositoryImpl())),
                    isActive: $isQuizViewPresented
                ) {
                    EmptyView()
                }
                
                Button(action: {
                    print("Start Quiz button was tapped")
                    // open the QuizView by passing questions
                    isQuizViewPresented = true
                    
                }) {
                    Text("Start Quiz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .buttonStyle(PlainButtonStyle()) // Removes the default button style
                
            }
        }
    }
}


#Preview {
    ContentView()
}
