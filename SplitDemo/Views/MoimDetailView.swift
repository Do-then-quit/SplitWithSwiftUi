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
