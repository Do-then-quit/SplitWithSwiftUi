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
                TextField("Spend", value: $newExpense.totalSpent, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                ForEach(newExpense.attendees) { attendee in
                    HStack {
                        Text(attendee.name)
                        Spacer()
                        TextField("\(newExpense.amountPerAttendee[attendee] ?? 0)", value: $newExpense.amountPerAttendee[attendee], format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                        
                    }
                }
                DatePicker(selection: $newExpense.date, label: { Text("Date") })
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        print(newExpense)
                        moim.expenses.append(newExpense)
                        newExpense = Moim.Expense(memo: "Memo", totalSpent: 0)
                        isPresentingExpenseAddSheet = false
                    }
                }
            }
            
        }
        .onAppear {
            // newExpense initial 2
            // state property가 필요할때 이렇게 하면 좋네요.
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
