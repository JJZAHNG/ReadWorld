//import SwiftUI
//import PDFKit
//
//// 这是封装的PDFView，用来展示PDF文件，并提供页码信息
//struct PDFKitView: UIViewRepresentable {
//    let pdfDocument: PDFDocument
//    let pdfView = PDFView() // 持有 PDFView 以便后续跳转页面
//    let currentPageIndexKey = "currentPageIndex" // 存储当前页码的键
//    @Binding var currentPage: Int // 当前页码
//    @Binding var totalPages: Int // 总页数
//    @Binding var shouldNavigateToQuiz: Bool // 用于触发跳转
//    @Binding var hasOutline: Bool // 用于指示是否显示目录按钮
//
//    func makeUIView(context: Context) -> PDFView {
//        pdfView.autoScales = true // 自动缩放PDF以适应视图
//        pdfView.displayMode = .singlePageContinuous // 设置连续多页模式
//        pdfView.displayDirection = .vertical // 竖直滚动
//
//        // 启用文档的页面滚动
//        pdfView.displaysAsBook = false
//
//        // 加载PDF文件
//        pdfView.document = pdfDocument
//
//        // 设置监听当前页码变化
//        pdfView.delegate = context.coordinator
//
//        // 恢复上次的阅读进度
//        if let savedPageIndex = UserDefaults.standard.value(forKey: currentPageIndexKey) as? Int,
//           let page = pdfDocument.page(at: savedPageIndex) {
//            pdfView.go(to: page)
//        }
//
//        // 更新总页数
//        totalPages = pdfDocument.pageCount
//
//        // 检查是否有目录
//        hasOutline = pdfDocument.outlineRoot != nil
//
//        return pdfView
//    }
//
//    func updateUIView(_ uiView: PDFView, context: Context) {
//        // 防止每次更新视图时重复加载
//        if uiView.document == nil {
//            uiView.document = pdfDocument
//        }
//    }
//
//    // 添加方法以便从外部跳转到指定的 PDF 页
//    func goToPage(_ page: PDFPage?) {
//        if let page = page {
//            pdfView.go(to: page)
//        }
//    }
//
//    // 创建 Coordinator 来处理 PDF 页码变化
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self, currentPage: $currentPage, shouldNavigateToQuiz: $shouldNavigateToQuiz)
//    }
//
//    // 协调器用于处理 PDF 页码变化
//    class Coordinator: NSObject, PDFViewDelegate {
//        var parent: PDFKitView
//        @Binding var currentPage: Int
//        @Binding var shouldNavigateToQuiz: Bool
//
//        init(_ parent: PDFKitView, currentPage: Binding<Int>, shouldNavigateToQuiz: Binding<Bool>) {
//            self.parent = parent
//            self._currentPage = currentPage
//            self._shouldNavigateToQuiz = shouldNavigateToQuiz
//        }
//
//        // 当页面变化时触发此代理方法
//        func pdfViewPageChanged(_ sender: PDFView) {
//            if let currentPage = sender.currentPage,
//               let currentPageIndex = sender.document?.index(for: currentPage) {
//                // 存储当前页面的索引
//                UserDefaults.standard.set(currentPageIndex, forKey: parent.currentPageIndexKey)
//                self.currentPage = currentPageIndex + 1 // 更新当前页码（1-based）
//
//                // 当用户到达特定的页码时，设置shouldNavigateToQuiz为true
//                let targetPageIndex = 5 // 设置触发跳转到Quiz的页码
//                if currentPageIndex == targetPageIndex {
//                    shouldNavigateToQuiz = true // 触发跳转到Quiz
//                }
//            }
//        }
//    }
//}
//
//// PDF目录项视图，展示PDF的大纲
//struct PDFOutlineView: View {
//    let pdfDocument: PDFDocument
//    let pdfView: PDFKitView // 传入PDFKitView以便跳转页面
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var outlineItems: [PDFOutline] = []
//
//    var body: some View {
//        NavigationView {
//            List(outlineItems, id: \.self) { outline in
//                if let label = outline.label {
//                    Button(action: {
//                        // 跳转到目录项对应的页面
//                        if let destination = outline.destination {
//                            pdfView.goToPage(destination.page)
//                        }
//                        // 关闭目录视图
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text(label)
//                    }
//                }
//            }
//            .navigationTitle("目录")
//            .onAppear {
//                if let rootOutline = pdfDocument.outlineRoot {
//                    outlineItems = getAllOutlineItems(rootOutline: rootOutline)
//                }
//            }
//        }
//    }
//
//    // 递归获取所有的PDF目录项
//    func getAllOutlineItems(rootOutline: PDFOutline) -> [PDFOutline] {
//        var items: [PDFOutline] = []
//        let count = rootOutline.numberOfChildren
//        for index in 0..<count {
//            if let child = rootOutline.child(at: index) {
//                items.append(child)
//                items.append(contentsOf: getAllOutlineItems(rootOutline: child))
//            }
//        }
//        return items
//    }
//}
//
//// 主页面 ReadPDFView
//struct ReadPDFView: View {
//    @State private var showOutline = false
//    @State private var pdfDocument: PDFDocument?
//    @State private var currentPage = 1 // 当前页码
//    @State private var totalPages = 1 // 总页数
//    @State private var shouldNavigateToQuiz = false // 控制是否跳转到Quiz
//    @State private var hasOutline = false // 指示是否显示目录按钮
//
//    var body: some View {
//        NavigationView { // 使用NavigationView来显示工具栏
//            VStack {
//                // 加载PDF文件，传递给PDFKitView
//                if let pdfDocument = pdfDocument {
//                    let pdfView = PDFKitView(pdfDocument: pdfDocument, currentPage: $currentPage, totalPages: $totalPages, shouldNavigateToQuiz: $shouldNavigateToQuiz, hasOutline: $hasOutline)
//                    pdfView
//                        .edgesIgnoringSafeArea(.all) // 全屏显示PDF
//                        .toolbar {
//                            // 仅当PDF有目录时显示目录按钮
//                            if hasOutline {
//                                ToolbarItem(placement: .navigationBarTrailing) {
//                                    Button(action: {
//                                        showOutline = true
//                                    }) {
//                                        Text("目录")
//                                    }
//                                    .sheet(isPresented: $showOutline) {
//                                        PDFOutlineView(pdfDocument: pdfDocument, pdfView: pdfView) // 将PDFView传入目录视图
//                                    }
//                                }
//                            }
//                        }
//                    
//                    // 显示当前页码和总页数
//                    Text("页码：\(currentPage) / \(totalPages)")
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .padding(.bottom, 10)
//
//                    // 添加一个NavigationLink，当shouldNavigateToQuiz为true时跳转到ChapterQuizView
//                    NavigationLink(destination: ChapterQuizView(), isActive: $shouldNavigateToQuiz) {
//                        EmptyView()
//                    }
//                } else {
//                    Text("未找到PDF文件")
//                }
//            }
//            .navigationBarTitle("PDF Viewer", displayMode: .inline) // 设置标题
//            .onAppear {
//                // 加载PDF文件
//                if let url = Bundle.main.url(forResource: "example", withExtension: "pdf") {
//                    pdfDocument = PDFDocument(url: url)
//                }
//            }
//        }
//    }
//}
//
//struct ReadPDFView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReadPDFView()
//    }
//}
