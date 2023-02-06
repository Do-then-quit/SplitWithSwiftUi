//
//  Moim.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import Foundation

struct Moim: Identifiable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var theme: Theme
    var expenses: [Expense] = []
    // var currency  // do i have to ?
    var tempTotalSobi: Int = 123456 // this is just for test.
    
    init(id: UUID = UUID(), title: String, attendees: [Attendee], theme: Theme, expenses: [Expense]) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.theme = theme
        self.expenses = expenses
    }
}

extension Moim {
    struct Attendee: Identifiable, Hashable {
        let id: UUID
        var name: String
        var totalSobi: Int = 0
        var totalPay: Int = 0
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, theme: theme)
    }
    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        theme = data.theme
    }
}

extension Moim {
    struct Expense: Identifiable {
        let id: UUID = UUID()
        var memo: String = ""
        // var currency
        var date: Date = Date()
        var totalSpent: Int = 0
        var attendees: [Attendee] = []
        var amountPerAttendee: [Attendee: Int] = [:]
        init(memo: String, totalSpent: Int) {
            self.memo = memo
            self.totalSpent = totalSpent
        }
        init(memo: String, totalSpent: Int, attendees: [Attendee]) {
            self.memo = memo
            self.totalSpent = totalSpent
            self.attendees = attendees
            for attendee in attendees {
                self.amountPerAttendee[attendee] = totalSpent / attendees.count
            }
        }
    }
    
    mutating func removeExpense(indices: IndexSet) -> Void {
        expenses.remove(atOffsets: indices)
    }
    
    func totalMoimSobi() -> Int {
        var temp = 0
        for expense in expenses {
            temp += expense.totalSpent
        }
        return temp
    }
}

extension Moim {
    static let sampleAttendee: [Attendee] = [
        Attendee(name: "Minamino"),
        Attendee(name: "Kubo"),
        Attendee(name: "Danaka")]
    
    static let sampleData: [Moim] =
    [
        Moim(title: "Tokyo",
             attendees: sampleAttendee,
             theme: .yellow,
             expenses: [
                Expense(memo: "first", totalSpent: 30000, attendees: sampleAttendee),
                Expense(memo: "Second", totalSpent: 1500, attendees: sampleAttendee),
             ]
            )
        ,
        Moim(title: "Seoul", attendees: [Attendee(name: "Minkyo"), Attendee(name: "JeongWon"), Attendee(name: "Ilsun")], theme: .orange, expenses: []),
        Moim(title: "LA", attendees: [Attendee(name: "Faker"), Attendee(name: "Deft"), Attendee(name: "Gumayusi")], theme: .poppy, expenses: [])
    ]
    
}
