import SwiftUI

// CatalogView expects a `Book` object, now properly handling chapters and quizzes
struct CatalogView: View {
    var book: Book  // Using the updated Book structure
    @AppStorage("userNickname") var nickname: String = ""
    @State private var bookProgress: Double = 0.0  // 使用 @State 来存储进度，并确保它可以动态更新
    @State private var needsRefresh: Bool = false  // 通过这个状态强制视图刷新
   
    var body: some View {
        VStack {
            // Scrollable content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Book cover, title, and author
                    VStack(alignment: .center) {
                        Image(book.coverImage)
                            .resizable()
                            .frame(width: 150, height: 220)
                            .cornerRadius(10)
                            .padding(.top, 20)
                        
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // 显示书籍阅读进度
                    Text(String(format: "Progress: %.0f%%", bookProgress * 100))
                    
                    // Book description
                    Text(book.description)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .multilineTextAlignment(.leading)
                    
                    // Chapter list with NavigationLink
                    Text("Chapters")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    ForEach(book.chapters) { chapter in
                        NavigationLink(destination: ChapterDetailView(chapter: chapter)) {
                            HStack {
                                Text(chapter.name)
                                    .font(.body)
                                    .padding(.vertical, 2)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear {
                loadProgress()  // 每次 CatalogView 出现时刷新进度
            }
            
            // Start reading button with progress
            NavigationLink(
                destination: ReaderView(bookTitle: book.title)
                    .onDisappear {
                        // 当 ReaderView 退出时，设置 needsRefresh 来强制刷新
                        needsRefresh.toggle()
                    }
            ) {
                Text("Start Reading")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .id(needsRefresh)  // 通过改变 ID 强制刷新视图
    }
    
    // 加载书籍进度的方法
    func loadProgress() {
        let userProgress = loadUserProgress(username: nickname)
        bookProgress = userProgress.booksProgress[book.title] ?? 0.0
    }
}


// Chapter Detail View for individual chapters, including quiz questions
struct ChapterDetailView: View {
    var chapter: Chapter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(chapter.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Summary")
                .font(.headline)
            
            Text(chapter.summary)
                .font(.body)
                .padding(.bottom, 20)
            
            Text("Quiz Questions")
                .font(.headline)
            
            ForEach(chapter.quiz, id: \.question) { quiz in
                VStack(alignment: .leading) {
                    Text("Q: \(quiz.question)")
                        .font(.body)
                        .padding(.vertical, 2)
                    
                    ForEach(quiz.options, id: \.self) { option in
                        Text("• \(option)")
                            .padding(.leading, 10)
                    }
                }
                .padding(.bottom, 10)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle(chapter.name)
    }
}
