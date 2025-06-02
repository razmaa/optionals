import Foundation

let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]


let discountedPrices: [Double] = books.compactMap { book in
    guard let price = book["price"] as? Int else { return nil }
    return Double(price) * 0.9
}

let booksPostedAfter2000: [String] = books
    .filter { book in
        if let year = book["year"] as? Int {
            return year > 2000
        }
        return false
    }
    .compactMap { book in
        book["title"] as? String
    }

let allGenres: Set<String> = Set(books.compactMap { $0["genre"] as? [String] }.flatMap { $0 })

let totalCost: Int = books
    .compactMap { $0["price"] as? Int }
    .reduce(0, +)

