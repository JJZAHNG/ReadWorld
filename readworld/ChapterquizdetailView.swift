import SwiftUI

struct ChapterQuizDetailView: View {
    var quiz: [Quiz]  // 传入测验数组
    var onQuizCompleted: () -> Void  // 回调函数，用于标记测验完成
    
    @State private var selectedAnswer: String? = nil
    @State private var isAnswerSubmitted: Bool = false
    @State private var isCorrect: Bool = false
    @State private var currentQuestionIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode  // 用于控制视图返回
    
    var body: some View {
        VStack {
            // 显示当前问题
            Text(quiz[currentQuestionIndex].question)
                .font(.headline)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
            
            // 答案选项列表
            VStack(spacing: 15) {
                ForEach(quiz[currentQuestionIndex].options, id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        isAnswerSubmitted = false  // 用户选择答案后重置提交状态
                    }) {
                        Text(answer)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedAnswer == answer ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                            .foregroundColor(selectedAnswer == answer ? .green : .black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedAnswer == answer ? Color.green : Color.clear, lineWidth: 2)
                            )
                            .cornerRadius(10)
                    }
                    .disabled(isAnswerSubmitted)  // 提交后禁用按钮
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
            
            // 提交按钮
            Button(action: {
                if let selected = selectedAnswer {
                    isCorrect = (selected == quiz[currentQuestionIndex].correctAnswer)  // 判断答案是否正确
                    isAnswerSubmitted = true  // 标记为已提交
                    
                    if isCorrect {
                        goToNextQuestion()  // 如果正确，进入下一题
                    } else {
                        resetAfterDelay()  // 如果错误，2秒后重置
                    }
                }
            }) {
                Text(isAnswerSubmitted && isCorrect ? "Next" : "Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isAnswerSubmitted ? (isCorrect ? Color.green : Color.red) : Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .disabled(selectedAnswer == nil || isAnswerSubmitted)  // 如果未选择答案或已提交，禁用按钮
            .padding(.bottom, 20) // 底部间距
            
            // 显示反馈
            if isAnswerSubmitted {
                Text(isCorrect ? "Correct! Moving to the next question..." : "Incorrect. Please try again.")
                    .font(.headline)
                    .foregroundColor(isCorrect ? .green : .red)
                    .padding(.top, 20)
            }
        }
        .navigationBarTitle("Question \(currentQuestionIndex + 1)", displayMode: .inline) // 设置导航栏标题
    }
    
    // 进入下一题函数
    func goToNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if currentQuestionIndex < quiz.count - 1 {
                // 进入下一题
                currentQuestionIndex += 1
                resetForNextQuestion()
            } else {
                // 最后一题，调用回调并返回 ChapterQuizView
                onQuizCompleted()  // 调用回调函数，标记测验完成
                presentationMode.wrappedValue.dismiss()  // 返回上一视图
            }
        }
    }
    
    // 当用户选择错误答案时，2秒后重置答题状态
    func resetAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            resetForNextQuestion()  // 重置状态以进行下一次答题
        }
    }

    // 重置状态以进行下一题
    func resetForNextQuestion() {
        selectedAnswer = nil
        isAnswerSubmitted = false
        isCorrect = false
    }
}

