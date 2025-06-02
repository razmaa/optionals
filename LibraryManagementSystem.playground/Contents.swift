import Foundation

// MARK: - Protocols and Extensions

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    mutating func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let dueDate = returnDate else { return false }
        return Date() > dueDate
    }
    
    mutating func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
        print("Item successfully checked in and is now available for borrowing.")
    }
}

// MARK: - Classes

class Item {
    var id: String
    var title: String
    var author: String

    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false

    init(id: String, title: String, author: String,
         borrowDate: Date? = nil,
         returnDate: Date? = nil,
         isBorrowed: Bool = false) {
        self.borrowDate = borrowDate
        self.returnDate = returnDate
        self.isBorrowed = isBorrowed
        super.init(id: id, title: title, author: author)
    }
}

class Library {
    private var items: [String: Item] = [:]
    
    func addBook(_ book: Book) {
        items[book.id] = book
        print("Added book: \(book.title)")
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard item is Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if (item as? Book)?.isBorrowed ?? false {
            throw LibraryError.alreadyBorrowed
        }
        
        (item as? Book)?.borrowDate = Date()
        (item as? Book)?.returnDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
        (item as? Book)?.isBorrowed = true
        
        print("Borrow process initiated for item: \(item.title)")
        return item
    }

}

// MARK: - Enums

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}
