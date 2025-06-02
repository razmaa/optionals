import Foundation

struct School {
    // MARK: - Nested Types
    
    enum SchoolRole {
        case student
        case teacher
        case administrator
    }
    
    class Person {
        var name: String
        var role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    // MARK: - Properties
    
    private var personnel: [Person] = []
    
    // MARK: - Subscripts
    
    subscript(role: SchoolRole) -> [Person] {
        return personnel.filter { $0.role == role }
    }
    
    // MARK: - Methods
    
    mutating func add(person: Person) {
        personnel.append(person)
    }
    
    func countStudents(school: School) -> Int {
        return school[.student].count
    }

    func countTeachers(school: School) -> Int {
        return school[.teacher].count
    }

    func countAdministrators(school: School) -> Int {
        return school[.administrator].count
    }

}

