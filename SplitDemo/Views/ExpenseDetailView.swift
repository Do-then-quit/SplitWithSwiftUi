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
        VStack {
            Text("\(expense.totalSpent)")
            List {
                ForEach(expense.amountPerAttendee.sorted(by: { first, second in
                    return first.key.name > second.key.name
                }), id: \.key) { key, value in
                    HStack {
                        Text(key.name)
                        Text("\(value)")
                    }
                }
            }
        }
        .navigationTitle(expense.memo)
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExpenseDetailView(expense: .constant(Moim.sampleData[0].expenses[0]))
        }
    }
}
