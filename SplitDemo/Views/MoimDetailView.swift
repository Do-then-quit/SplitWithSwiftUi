//
//  MoimDetailView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

struct MoimDetailView: View {
    @Binding var moim: Moim
    @State private var isPresentingExpenseAddSheet = false
    struct ExpenseGroup {
        let date: Date
        let expenses: [Moim.Expense]

        init(date: Date, expenses: [Moim.Expense]) {
            self.date = date
            self.expenses = expenses
        }
        init(group: (key: Date, value: [Moim.Expense])){
            self.date = group.key
            self.expenses = group.value
        }
    }
    
    private var groupedExpenses: [ExpenseGroup] {
        Dictionary(grouping: moim.expenses, by: { Calendar.current.startOfDay(for: $0.date) })
                .map(ExpenseGroup.init)
                .sorted(by: { $0.date > $1.date })
        }
    
    var body: some View {
        List {
//            ForEach($moim.expenses) { $expense in
//                NavigationLink(destination: ExpenseDetailView(expense: $expense)) {
//                    ExpenseCardView(expense: expense)
//                }
//            }
//            .onDelete { indices in
//                moim.expenses.remove(atOffsets: indices)
//            }
            
            ForEach(groupedExpenses, id: \.date) { group in
                Section(header: Text("\(group.date)")) {
                    ForEach(group.expenses) { expense in
                        NavigationLink(destination: ExpenseDetailView(moim: $moim, expense: expense)) {
                            ExpenseCardView(expense: expense)
                        }
                    }
                }
            }
        }
        .navigationTitle(moim.title)
        .toolbar {
            Button("Add") {
                isPresentingExpenseAddSheet = true
            }
        }
        .sheet(isPresented: $isPresentingExpenseAddSheet) {
            ExpenseAddView(moim: $moim, isPresentingExpenseAddSheet: $isPresentingExpenseAddSheet)
            
        }
    }
}

struct MoimDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoimDetailView(moim: .constant(Moim.sampleData[0]))
        }
    }
}
