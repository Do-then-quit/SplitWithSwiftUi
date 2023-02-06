//
//  ExpenseDetailView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/02/04.
//

import SwiftUI

struct ExpenseDetailView: View {
    @Binding var expense:Moim.Expense
    var body: some View {
        VStack(alignment: .leading) {
            Text("총 소비 액 : \(expense.totalSpent)")

            List {
                ForEach(expense.attendees) { attendee in
                    if let val =  expense.amountPerAttendee[attendee] {
                        HStack {
                            Text(attendee.name)
                            Spacer()
                            Text("\(val)")
                        }
                    } else {
                        HStack {
                            Text(attendee.name)
                            Spacer()
                            Text("\(0)")
                        }
                    }
                }
            }
            Text(expense.date.description)
        }
        .navigationTitle(expense.memo)
        .padding()
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExpenseDetailView(expense: .constant(Moim.sampleData[0].expenses[0]))
        }
    }
}
