//
//  ContentView.swift
//  Magic8Ball
//
//  Created by Steven Wijaya on 25.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var showAlert: Bool = false
    
    @State private var shake: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    TextField("Enter a yes/no question", text: $question)
                    HStack {
                        Spacer()
                        Button {
                            question = ""
                            answer = ""
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 4)
                }
                .padding(.bottom)
                HStack {
                    Spacer()
                    Button {
                        if question != "" {
                            shake.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
                                answer = generateResult()
                            }
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text("Generate answer")
                            .foregroundColor(.primary)
                            .colorInvert()
                            .frame(width: 175, height: 45)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                ZStack {
                    Circle()
                        .frame(width: 350)
                    Circle()
                        .frame(width: 175)
                        .foregroundColor(.white)
                        .overlay {
                            if answer != "" {
                                Text(answer)
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                                    .padding(1)
                            } else {
                                Text("8")
                                    .font(.system(size: 90))
                            }
                        }
                }
                .offset(x: shake ? -10 : 0)
                .animation(.default.repeatCount(30).speed(10), value: shake)
                
            }
            .padding()
            .navigationTitle("Magic 8 Ball")
            .alert("Empty Question", isPresented: $showAlert) {
                Button(role: .cancel) {
                    //
                } label: {
                    Text("Ok")
                }

            } message: {
                Text("Please enter a valid yes/no question.")
            }
        }
    }
    
    func generateResult() -> String {
        let generatedP = Double.random(in: 0...1)
        let indexCalc = generatedP / base
        let index: Int = Int(indexCalc.rounded(.down))
        
        return possibleAnswers[index]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
