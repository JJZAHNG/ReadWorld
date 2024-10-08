import SwiftUI

struct ChapterQuizView: View {
    var bookTitle: String  // Book title passed as a parameter
    var chapterTitle: String  // Chapter title passed as a parameter

    @AppStorage("userNickname") var nickname: String = ""  // Get the current user's nickname
    @Environment(\.presentationMode) var presentationMode  // Control for returning to the previous view
    @State private var quizCompleted: Bool = false  // Track quiz completion
    @State private var isGeneratingSummary: Bool = true  // Simulate the chapter summary generation process
    @State private var showSummary: Bool = false  // Control whether to show the chapter summary

    var body: some View {
        VStack {
            Spacer()

            // Icon and message
            VStack(spacing: 20) {
                Image(systemName: quizCompleted ? "checkmark.circle" : "party.popper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(quizCompleted ? .green : .blue) // Change to green when the quiz is completed

                // Fetch the chapter summary
                if let chapter = getChapter(by: chapterTitle, in: bookTitle) {
                    Text(quizCompleted ? "Congratulations, you have completed the quiz for this chapter!" : "You have finished reading this chapter!\nYou can take the quiz.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 40)
                    
                    // Display the summary generation process
                    if isGeneratingSummary {
                        Text("Generating chapter summary...")
                            .font(.body)
                            .foregroundColor(.blue)
                            .padding(.top, 20)
                    } else if showSummary {
                        // Show chapter summary
                        Text("Chapter Summary: \(chapter.summary)")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.horizontal, 40)
                            .padding(.top, 20)
                    }
                }
            }

            Spacer()

            // "Take the Chapter Quiz" button (displayed based on quiz completion status)
            if !quizCompleted {
                // Get the quiz array based on the chapter
                if let chapter = getChapter(by: chapterTitle, in: bookTitle) {
                    NavigationLink(destination: ChapterQuizDetailView(quiz: chapter.quiz, onQuizCompleted: {
                        quizCompleted = true  // Update the status when the quiz is completed
                        saveQuizCompletion()  // Save the quiz completion status
                    })) {
                        Text("Take the Chapter Quiz")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20) // Leave space below the button
                }
            }

            // Custom return button
            Button(action: {
                presentationMode.wrappedValue.dismiss()  // Return to the ReaderView
            }) {
                Text("Back")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 20) // Leave space below the button
        }
        .onAppear {
            loadQuizCompletion()  // Check quiz completion status when the view loads
            startSummaryGeneration()  // Simulate the chapter summary generation process
        }
        .navigationBarTitle(chapterTitle, displayMode: .inline) // Set the navigation bar title
    }

    // Simulate chapter summary generation
    func startSummaryGeneration() {
        // Simulate a 2-second generation process
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isGeneratingSummary = false
            self.showSummary = true
        }
    }

    // Load quiz completion status
    func loadQuizCompletion() {
        if let completed = UserDefaults.standard.value(forKey: "\(nickname)_\(bookTitle)_\(chapterTitle)_quizCompleted") as? Bool {
            quizCompleted = completed
        }
    }

    // Save quiz completion status
    func saveQuizCompletion() {
        UserDefaults.standard.setValue(true, forKey: "\(nickname)_\(bookTitle)_\(chapterTitle)_quizCompleted")
    }

    // Get chapter by title and book
    func getChapter(by chapterTitle: String, in bookTitle: String) -> Chapter? {
        guard let book = recommendedBooks.first(where: { $0.title == bookTitle }) else {
            return nil
        }
        return book.chapters.first(where: { $0.name == chapterTitle })
    }
}

struct ChapterQuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChapterQuizView(bookTitle: "The Very Hungry Caterpillar", chapterTitle: "Chapter I: The Egg and the Caterpillar")
        }
    }
}
