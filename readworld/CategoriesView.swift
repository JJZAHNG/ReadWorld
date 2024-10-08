import SwiftUI

struct CategoriesView: View {
    var category: String
    var books: [Book] // Receives the books under this category

    var body: some View {
        List(books) { book in
            NavigationLink(destination: CatalogView(book: book)) {
                HStack {
                    Image(book.coverImage)
                        .resizable()
                        .frame(width: 50, height: 75)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(book.description)
                            .font(.caption)
                            .lineLimit(2)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle(category)  // Use the category name as the navigation title
        .navigationBarTitleDisplayMode(.inline) // Centered navigation bar title
    }
}


