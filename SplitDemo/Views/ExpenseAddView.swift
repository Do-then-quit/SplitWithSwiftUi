//
//  ExpenseAddView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/31.
//

import SwiftUI

struct ExpenseAddView: View {
    //마찬가지로 무엇을 받아야하는지 확실히하자.
    @Binding var moim: Moim
    @Binding var newExpense: Moim.Expense
    @Binding var isPresentingExpenseAddSheet: Bool
    var moimAttendees: [Moim.Attendee]


    var body: some View {
        NavigationView {
            VStack {
                TextField("Memo", text: $newExpense.memo)
                TextField("Spend", value: $newExpense.totalSpent, formatter: NumberFormatter())
                
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        moim.expenses.append(newExpense)
                        newExpense = Moim.Expense(memo: "Initial", totalSpent: 0)
                        isPresentingExpenseAddSheet = false
                    }
                }
            }
            
        }
    }
}

struct ExpenseAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseAddView(moim: .constant(Moim.sampleData[0]), newExpense: .constant(Moim.Expense(memo: "Initial", totalSpent: 0)), isPresentingExpenseAddSheet: .constant(false), moimAttendees: Moim.sampleData[0].attendees)
    }
}
