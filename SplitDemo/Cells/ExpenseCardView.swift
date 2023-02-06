//
//  ExpenseCardView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

struct ExpenseCardView: View {
    let expense: Moim.Expense
    var body: some View {
        VStack {
            HStack {
                Text(expense.memo)
                Spacer()
                Text("\(expense.totalSpent)")
            }
            .padding()
            Text(expense.date.description)
        }
    }
}

struct ExpenseCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseCardView(expense: Moim.sampleData[0].expenses[0])
    }
}
