//: Playground - noun: a place where people can play

import UIKit

class Question {
    
    private static var idCounter = 1
    
    let questionId: Int
    let prompt: String
    var answer: Any?
    
    init(prompt: String) {
        self.questionId = Question.idCounter
        Question.idCounter += 1
        self.prompt = prompt
    }
    
    var field: String {
        fatalError("Must override")
    }
    
    func display() {
        print("\(prompt)\n\t\(field)")
    }
    
    func answer(value: Any) {
        print("\t\t--> \(value)")
        answer = value
        if validateAnswer() {
            print("\t\t\t✅")
        } else {
            print("\t\t\t🚫")
        }
    }
    
    func validateAnswer() -> Bool {
        fatalError()
    }
}

class TextQuestion : Question {
    override var field: String {
        return "[textfield]"
    }
    
    override func validateAnswer() -> Bool {
        guard let s = answer as? String else { return false }
        return s.count > 0
    }
}

class NumericQuestion : Question {
    override var field: String {
        return "[stepper]"
    }
    
    override func validateAnswer() -> Bool {
        guard let n = answer as? Int else { return false }
        return n >= 0
    }
}

class BooleanQuestion : Question {
    override var field: String {
        return "[switch]"
    }
    
    override func validateAnswer() -> Bool {
        return answer is Bool
    }
}

class FileQuestion : Question {
    override var field: String {
        return "[filepicker]"
    }
    
    override func validateAnswer() -> Bool {
        guard let url = answer as? URL else { return false }
        return url.isFileURL
    }
}

let quiz = [
    TextQuestion(prompt: "Favorite cereal?"),
    TextQuestion(prompt: "Favorite movie?"),
    NumericQuestion(prompt: "How many pets do you have?"),
    BooleanQuestion(prompt: "Have you ever been skydiving?"),
    FileQuestion(prompt: "take a selfie!")
]

func answerQuestion(_ question: Question) {
    switch question.questionId {
    case 1: question.answer(value: "Cheerios")
    case 2: question.answer(value: "Godfather")
    case 3: question.answer(value: 1)
    case 4: question.answer(value: false)
    case 5: question.answer(value: URL(fileURLWithPath: "/Users/ben/Desktop/ben.png"))
    default: fatalError()
    }
}

func display(quiz: [Question]) {
    for question in quiz {
        question.display()
        
        answerQuestion(question)
    }
}

display(quiz: quiz)
