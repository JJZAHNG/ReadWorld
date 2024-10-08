import SwiftUI

struct BookStoreView: View {
    @State private var searchText = "" // Search bar text

    // Filtered books based on the search
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return recommendedBooks
        } else {
            return recommendedBooks.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            // Search bar
            TextField("Search Books", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            // Recommended Books Section
            Text("Recommended For You")
                .font(.headline)
                .padding([.horizontal, .top])

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filteredBooks) { book in
                        NavigationLink(destination: CatalogView(book: book)) {
                            VStack {
                                Image(book.coverImage)
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)

                                Text(book.title)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(width: 100)
                            }
                            .padding(.leading, book == filteredBooks.first ? 20 : 0)
                            .padding(.trailing, 10)
                        }
                    }
                }
            }

            // Category Section
            Text("Categories")
                .font(.headline)
                .padding([.horizontal, .top])

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(getCategories()) { category in
                        NavigationLink(destination: CategoriesView(
                            category: category.name,
                            books: getBooksForCategory(category: category.name)
                        )) {
                            ZStack {
                                // Category image with label overlay
                                Image(category.image) // Use the image from the category
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                                    .overlay(
                                        Text(category.name.capitalized)
                                            .font(.title3)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(5)
                                            .offset(y: 40) // Adjust label position
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2) // Blue border
                                    )
                            }
                        }
                        .padding(.leading, category == getCategories().first ? 20 : 0)
                        .padding(.trailing, 10)
                    }
                }
            }

            // Popular Books Section
            Text("Popular Books")
                .font(.headline)
                .padding([.horizontal, .top])

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(popularBooks) { book in
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

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
}

// Main View with TabBar
struct BookstoreViewWithBar: View {
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


struct BookStoreView_Previews: PreviewProvider {
    static var previews: some View {
        BookstoreViewWithBar()
    }
}
