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
    // newExpense initial 1
    @State var newExpense: Moim.Expense = Moim.Expense(memo: "", totalSpent: 0)
    @Binding var isPresentingExpenseAddSheet: Bool


    var body: some View {
        NavigationView {
            VStack {
                TextField("Memo", text: $newExpense.memo)
                    .textFieldStyle(.roundedBorder)
                TextField("Spend", value: $newExpense.totalSpent, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                ForEach(newExpense.attendees) { attendee in
                    HStack {
                        Text(attendee.name)
                        Spacer()
                        TextField("소비 한 금액", value: $newExpense.amountPerAttendee[attendee], formatter: NumberFormatter())
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    // 슷자 입력 후에 숫자가 없어지고 이름이 보이는 현상이 있는데스...
                }
            }
            .padding()
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
        .onAppear {
            // newExpense initial 2
            newExpense.attendees = moim.attendees
            for attendee in newExpense.attendees {
                newExpense.amountPerAttendee[attendee] = 0
            }
        }
    }
}

struct ExpenseAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseAddView(moim: .constant(Moim.sampleData[0]), isPresentingExpenseAddSheet: .constant(false))
    }
}
