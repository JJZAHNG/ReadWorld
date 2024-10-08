import SwiftUI

struct ReadhistoryView: View {
    @AppStorage("userNickname") var nickname: String = ""
    @State var currentUserProgress: UserBookProgress?
    @State var progressData: [String: Double] = [:]  // 用于存储每本书的进度
    @State var readingHistory: [Book] = [] // 阅读历史书籍
    @State private var needsRefresh: Bool = false  // 用于强制刷新视图

    var body: some View {
        VStack(alignment: .leading) {
            // 阅读历史部分
            Text("Your Reading History")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 20)

            if !readingHistory.isEmpty {
                ScrollView {
                    ForEach(readingHistory, id: \.id) { book in
                        if let progress = progressData[book.title] {
                            VStack(alignment: .leading) {
                                NavigationLink(
                                    destination: ReaderView(bookTitle: book.title)
                                        .onAppear {
                                            // 从 ReaderView 回到此页面时，刷新进度
                                            refreshProgress()
                                        }
                                        .onDisappear {
                                            needsRefresh.toggle()  // 在 ReaderView 消失时触发刷新
                                        }
                                ) {
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
                Text("No reading history.")
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
                readingHistory = getUserHistoryBooks(for: nickname)  // 加载用户的阅读历史
            }
            refreshProgress()  // 进入页面时刷新进度
        }
//        .navigationBarHidden(true)
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

struct ReadhistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewWithTabBar()
    }
}
