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
    // Expense Data
    @State private var newExpense = Moim.Expense(memo: "Initial", totalSpent: 0)
    
    var body: some View {
        List {
            ForEach(moim.expenses) { expense in
                ExpenseCardView(expense: expense)
            }
            .onDelete { indices in
                moim.expenses.remove(atOffsets: indices)
            }
            
        }
        .navigationTitle(moim.title)
        .toolbar {
            Button("Add") {
                isPresentingExpenseAddSheet = true
            }
        }
        .sheet(isPresented: $isPresentingExpenseAddSheet) {
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
}

struct MoimDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoimDetailView(moim: .constant(Moim.sampleData[0]))
        }
    }
}
