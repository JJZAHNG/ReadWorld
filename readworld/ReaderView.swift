import SwiftUI
import PDFKit

struct ReaderView: View {
    var bookTitle: String  // Retain bookTitle as a parameter

    @AppStorage("userNickname") var nickname: String = ""
    @State private var pdfDocument: PDFDocument?
    @State private var currentPage: Int = 0
    @State private var totalPages: Int = 0
    @State private var progress: Double = 0.0
    @State private var currentChapter: Chapter?  // Store the current triggered quiz chapter
    @State private var completedQuizzes: Set<String> = [] // Store completed chapter quizzes

    @State private var navigateToQuiz: Bool = false // Control navigation to chapter quiz

    var body: some View {
        VStack {
            if let document = pdfDocument {
                PDFKitRepresentedView(document: document, currentPage: $currentPage, progress: progress)
                    .onAppear {
                        totalPages = document.pageCount
                        let pageIndex = Int(progress * Double(totalPages - 1)) // Ensure the page from 0% to 100%
                        currentPage = pageIndex + 1 // Page numbering starts from 1
                        
                        // Load completed quizzes and then check for quiz trigger
                        loadCompletedQuizzes {
                            print("Completed quizzes loaded: \(completedQuizzes)")
                            checkForQuizTrigger() // Call this after loading completed quizzes
                        }
                    }
                    .onChange(of: currentPage) { newPage in
                        checkForQuizTrigger()  // Check if the chapter quiz should be triggered when the current page changes
                    }
                    .onDisappear {
                        let currentProgress = Double(currentPage - 1) / Double(totalPages - 1) // Progress range from 0.0 to 1.0
                        if !nickname.isEmpty {
                            updateUserProgress(for: nickname, bookTitle: bookTitle, progress: currentProgress)
                        }
                    }
            } else {
                Text("Loading PDF file...")
            }

            HStack {
                Text("Page: \(currentPage)/\(totalPages)")
            }
            .padding()

            // NavigationLink to trigger chapter quiz
            NavigationLink(
                destination: ChapterQuizView(bookTitle: bookTitle, chapterTitle: currentChapter?.name ?? ""),
                isActive: $navigateToQuiz
            ) {
                EmptyView() // Hidden link, activated when navigateToQuiz is triggered
            }
        }
        .onAppear {
            loadPDFDocument()
            loadProgress() // Load user progress
        }
        .navigationTitle(bookTitle)
    }

    // Load the PDF file
    func loadPDFDocument() {
        if let fileURL = Bundle.main.url(forResource: bookTitle.replacingOccurrences(of: " ", with: "_"), withExtension: "pdf") {
            pdfDocument = PDFDocument(url: fileURL)
        } else {
            print("PDF file not found")
        }
    }

    // Load user progress
    func loadProgress() {
        let userProgress = loadUserProgress(username: nickname)
        if let bookProgress = userProgress.booksProgress[bookTitle] {
            progress = bookProgress
            print("Loaded progress for book \(bookTitle): \(progress)")
        } else {
            progress = 0.0 // Start from the beginning if no progress is found
            print("No saved progress found for book \(bookTitle), starting from the beginning.")
        }
    }
    
    // Check if the chapter quiz should be triggered
    func checkForQuizTrigger() {
        guard let book = getBookByTitle(bookTitle) else {
            return
        }
        
        print("Completed Quizzes: \(completedQuizzes)")  // Debugging output to check the completed quizzes

        // Loop through each chapter to check quiz trigger conditions
        for chapter in book.chapters {
            // If the chapter quiz is already completed, skip this chapter
            if completedQuizzes.contains(chapter.name) {
                continue
            }

            // If currentPage matches the chapter's pageNumber, trigger the quiz for that chapter
            if currentPage == chapter.pageNumber {
                currentChapter = chapter
                navigateToQuiz = true // Trigger navigation to the quiz view
                break
            }
        }
    }

    // 加载已完成的章节测验，带有回调函数
    func loadCompletedQuizzes(completion: @escaping () -> Void) {
        // 遍历所有章节，检查它们是否已经完成测验
        guard let book = getBookByTitle(bookTitle) else {
            completion()  // 如果书籍不存在，调用回调
            return
        }

        // 清空当前completedQuizzes
        completedQuizzes.removeAll()

        // 遍历书籍中的所有章节，加载每个章节的测验完成状态
        for chapter in book.chapters {
            let key = "\(nickname)_\(bookTitle)_\(chapter.name)_quizCompleted"
            if let quizCompleted = UserDefaults.standard.value(forKey: key) as? Bool, quizCompleted {
                completedQuizzes.insert(chapter.name)  // 如果测验已完成，插入章节名
            }
        }
        completion()  // 状态加载完成后调用回调
    }

    // 根据书名获取书籍信息
    func getBookByTitle(_ title: String) -> Book? {
        return recommendedBooks.first { $0.title == title }
    }

}


// Render the PDF file using PDFKit
struct PDFKitRepresentedView: UIViewRepresentable {
    let document: PDFDocument
    @Binding var currentPage: Int
    let progress: Double
    @State private var didLoadProgress = false // Mark whether progress has been loaded

    class Coordinator: NSObject, PDFViewDelegate {
        var parent: PDFKitRepresentedView

        init(_ parent: PDFKitRepresentedView) {
            self.parent = parent
        }

        // Triggered when the PDF page changes
        @objc func pdfViewPageChanged(_ sender: Notification) {
            if let pdfView = sender.object as? PDFView, let page = pdfView.currentPage {
                let pageNumber = page.pageRef?.pageNumber ?? 1
                if pageNumber != self.parent.currentPage {
                    self.parent.currentPage = pageNumber
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous // Enable scrolling for multiple pages
        pdfView.displayDirection = .vertical         // Vertical scrolling
        pdfView.usePageViewController(true)          // Use page view controller

        pdfView.delegate = context.coordinator

        // On the first load, set the page according to progress
        if !didLoadProgress {
            DispatchQueue.main.async {
                let totalPages = document.pageCount
                let pageIndex = Int(progress * Double(totalPages - 1)) // Determine the page based on progress
                if let page = document.page(at: pageIndex) {
                    pdfView.go(to: page)
                    currentPage = pageIndex + 1 // Update currentPage
                }
                didLoadProgress = true // Mark as progress loaded
            }
        }

        // Monitor page change notifications
        NotificationCenter.default.addObserver(context.coordinator,
                                               selector: #selector(Coordinator.pdfViewPageChanged(_:)),
                                               name: .PDFViewPageChanged,
                                               object: pdfView)

        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the page if the current page does not match the displayed page in PDFView
        if let currentPdfPage = uiView.currentPage,
           let currentPdfPageNumber = currentPdfPage.pageRef?.pageNumber,
           currentPdfPageNumber != currentPage {
            if let page = document.page(at: currentPage - 1) { // currentPage starts from 1
                uiView.go(to: page)
            }
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReaderView(bookTitle: "The Very Hungry Caterpillar")
        }
    }
}
