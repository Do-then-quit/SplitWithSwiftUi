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
            // view 를 쪼개서 다시 필요한 데이터를 넘기자.
            // 캬 넘겼다! 근데 넘겨서 뭐함.
            // 뭘 설정해서 넘겨야 하는지 확실히 정할 필요가 있다. 천천히 생각하죠.
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
