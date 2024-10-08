import SwiftUI
import PDFKit

// PDFKit View to display PDF content
struct PDFKitView: UIViewRepresentable {
    var pdfDocument: PDFDocument
    @Binding var currentPage: Int
    var pdfView = PDFView() // Keep a reference to the PDFView

    class Coordinator: NSObject, PDFViewDelegate {
        var parent: PDFKitView
        
        init(_ parent: PDFKitView) {
            self.parent = parent
        }
        
        // Listen to zooming in/out actions
        func pdfViewWillChangeScaleFactor(_ pdfView: PDFView, toScale newScale: CGFloat) {
            updateCurrentPage(pdfView)
        }
        
        // Listen to page change notifications
        @objc func pdfViewPageChanged(_ notification: Notification) {
            guard let pdfView = notification.object as? PDFView else { return }
            updateCurrentPage(pdfView)
        }
        
        // Update the current page based on the current PDF page
        func updateCurrentPage(_ pdfView: PDFView) {
            if let currentPage = pdfView.currentPage {
                DispatchQueue.main.async {
                    self.parent.currentPage = (pdfView.document?.index(for: currentPage) ?? 0) + 1
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> PDFView {
        pdfView.delegate = context.coordinator
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous // Support scrolling between pages
        pdfView.displayDirection = .vertical // Vertical scroll direction

        // Add observer to listen to page changes
        NotificationCenter.default.addObserver(context.coordinator,
                                               selector: #selector(Coordinator.pdfViewPageChanged(_:)),
                                               name: .PDFViewPageChanged,
                                               object: pdfView)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        // Ensure PDFView updates to the correct page when currentPage changes
        if currentPage > 0, let page = pdfDocument.page(at: currentPage - 1) {
            uiView.go(to: page)
        }
    }
}

struct ReadPDFView: View {
    @State private var currentPage: Int = 1
    @State private var showChapterQuiz: Bool = false // Control chapter quiz view display
    @State private var pdfView = PDFView() // Reference to PDFView
    var progress: Double // Current reading progress
    var bookTitle: String // Current book title
    @AppStorage("userNickname") var nickname: String = "" // Username

    // Load PDF based on bookTitle
    var pdfDocument: PDFDocument? {
        if let pdfURL = Bundle.main.url(forResource: bookTitle, withExtension: "pdf") {
            return PDFDocument(url: pdfURL)
        }
        return nil
    }

    var body: some View {
        VStack {
            if let pdfDocument = pdfDocument {
                PDFKitView(pdfDocument: pdfDocument, currentPage: $currentPage, pdfView: pdfView)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Display current page number and total pages
                Text("Page: \(currentPage) / \(pdfDocument.pageCount)")
            } else {
                Text("PDF not found")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            // Set initial page based on saved progress
            if currentPage == 1, let pageCount = pdfDocument?.pageCount {
                let targetPage = Int(progress * Double(pageCount)) // Calculate target page
                currentPage = targetPage > 0 ? targetPage : 1 // Set initial page to calculated result
            }
        }
        .onDisappear {
            // Save progress when view disappears
            if let pdfDocument = pdfDocument {
                let totalPageCount = pdfDocument.pageCount
                let newProgress = Double(currentPage) / Double(totalPageCount)
                updateUserProgress(for: nickname, bookTitle: bookTitle, progress: newProgress)
            }
        }
    }
}

