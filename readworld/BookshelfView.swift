import SwiftUI

struct BookshelfView: View {
    @State var currentlyReadingBooks: [Book] = []  // 将 currentlyReadingBooks 设置为 @State
    @AppStorage("userNickname") var nickname: String = ""
    @State var bookProgress: [String: Double] = [:]  // 存储每本书的进度
    @State private var isLoading: Bool = true  // 加载状态

    var body: some View {
        VStack(alignment: .leading) {
            // "My Bookshelf" 标题
            Text("My Bookshelf")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            // "Currently Reading" 子标题
            Text("Currently Reading")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 16)
                .padding(.top, 8)
            
            // 使用 LazyVGrid 来布局书籍封面
            if isLoading {
                // 如果正在加载数据，显示一个进度指示器
                ProgressView("Loading your bookshelf...")
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(currentlyReadingBooks) { book in
                            let progress = bookProgress[book.title] ?? 0.0  // 获取每本书的进度
                            
                            NavigationLink(destination: ReaderView(bookTitle: book.title)
                                .onDisappear {
                                    // 当阅读页面消失时，刷新进度
                                    refreshProgress()
                                }
                            ) {
                                VStack {
                                    Image(book.coverImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(8)
                                    
                                    Text(book.title)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)
                                        .frame(width: 100)
                                    
                                    // 显示进度条
                                    ProgressView(value: progress)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                                        .frame(height: 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, -20)
        .padding(.bottom, 10)
        .onAppear {
            // 当页面出现时，先加载书籍再刷新进度
            loadBooksAndProgress()
        }
    }
    
    // 加载书籍并刷新书籍进度的方法
    func loadBooksAndProgress() {
        // 加载书籍
        if !nickname.isEmpty {
            currentlyReadingBooks = getUserCurrentlyReadingBooks(for: nickname)
        }
        
        // 加载完书籍后刷新进度
        refreshProgress()
        
        // 数据加载完成，更新 isLoading 状态
        isLoading = false
    }
    
    // 刷新书籍进度的方法
    func refreshProgress() {
        var newProgress: [String: Double] = [:]
        for book in currentlyReadingBooks {
            // 从 UserDefaults 加载每本书的进度
            let progress = loadUserProgress(username: nickname).booksProgress[book.title] ?? 0.0
            newProgress[book.title] = progress
        }
        bookProgress = newProgress  // 更新进度字典
    }
}

struct BookshelfViewWithTabBar: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                BookStoreView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Bookstore")
                    }
                
                BookshelfView()
                    .tabItem {
                        Image(systemName: "books.vertical.fill")
                        Text("Bookshelf")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .accentColor(.blue)
        }
    }
}

// Example Preview
struct BookshelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookshelfViewWithTabBar()
    }
}
