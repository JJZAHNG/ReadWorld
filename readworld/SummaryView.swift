import SwiftUI

struct SummaryView: View {
    var chapterTitle: String = "第 1 章"  // 章节标题可以动态传递
    var bookSummary: String  // 书籍总结
    
    var body: some View {
        VStack {
            Text("章节总结")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("章节: \(chapterTitle)")
                .font(.headline)
                .padding(.top, 10)
            
            Text(bookSummary)  // 显示书籍总结
                .font(.body)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        .navigationBarTitle("Summary", displayMode: .inline)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(bookSummary: "在本章中，Wilbur 学会了勇气的重要性，并结识了 Charlotte，谁将成为他最好的朋友。")
    }
}
