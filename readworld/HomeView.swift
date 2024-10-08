import SwiftUI

struct HomeView: View {
    @AppStorage("userNickname") var nickname: String = ""
    @State var currentUserProgress: UserBookProgress?
    @State var progressData: [String: Double] = [:]  // 用于存储每本书的进度
    @State var currentlyReadingBooks: [Book] = [] // 将 currentlyReadingBooks 设置为 @State
    @State private var needsRefresh: Bool = false  // 用于强制刷新视图

    var body: some View {
        VStack(alignment: .leading) {
            // 用户问候和头像
            HStack {
                VStack(alignment: .leading) {
                    Text("Hello!")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(.gray)
                    
                    Text(nickname.isEmpty ? "Reader" : nickname)
                        .font(.system(size: 32, weight: .bold))
                        .padding(.top, 1)
                }
                
                Spacer()
                
                Image("avatar1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.trailing)
                    .shadow(radius: 1)
            }
            .padding(.horizontal)

            // 推荐书籍部分
            Text("Recommended For You")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(getRecommendedBooks()) { book in
                        NavigationLink(destination: CatalogView(book: book)) {
                            VStack {
                                Image(book.coverImage)
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                                
                                Text(book.title)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .frame(width: 100)
                            }
                            .padding(.leading, book == getRecommendedBooks().first ? 20 : 0)
                            .padding(.trailing, 10)
                        }
                    }
                }
            }

            // 当前阅读进度部分
            if !currentlyReadingBooks.isEmpty {
                Text("Your Reading Progress")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top, 20)

                ScrollView {
                    ForEach(currentlyReadingBooks, id: \.id) { book in
                        if let progress = progressData[book.title] {
                            VStack(alignment: .leading) {
                                NavigationLink(destination: ReaderView(bookTitle: book.title)) {
                                    HStack {
                                        Image(book.coverImage)
                                            .resizable()
                                            .frame(width: 50, height: 75)
                                            .cornerRadius(8)

                                        VStack(alignment: .leading) {
                                            Text(book.title)
                                                .font(.system(size: 18, weight: .semibold))

                                            // 进度条
                                            ProgressView(value: progress)
                                                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                                                .frame(height: 8)

                                            Text("\(Int(progress * 100))% completed")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.leading, 10)

                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }
            } else {
                Text("No books in progress.")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }

            Spacer()
        }
        .padding(.bottom, 10) // 给 TabView 留出空间
        .id(needsRefresh)  // 通过改变 needsRefresh 强制刷新视图
        .onAppear {
            if !nickname.isEmpty {
                currentlyReadingBooks = getUserCurrentlyReadingBooks(for: nickname)  // 加载正在阅读的书籍
            }
            refreshProgress()  // 进入页面时刷新进度
        }
        .navigationBarHidden(true)
    }
    
    // 刷新用户进度并强制刷新视图
    func refreshProgress() {
        // 每次视图出现时，重新加载用户进度
        currentUserProgress = loadUserProgress(username: nickname)
        
        // 更新每本书的进度
        if let progressInfo = currentUserProgress?.booksProgress {
            progressData = progressInfo
        }
    }
}

// Main view with TabView
struct HomeViewWithTabBar: View {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewWithTabBar()
    }
}
