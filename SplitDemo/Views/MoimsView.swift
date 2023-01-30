//
//  MoimsView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

struct MoimsView: View {
    @Binding var moims: [Moim]
    @State private var isPresentingNewMoimView = false
    @State private var newMoimData = Moim.Data()
    var body: some View {
        List {
            ForEach($moims) { $moim in
                NavigationLink(destination: MoimDetailView(moim: $moim))
                {
                    MoimCardView(moim: moim)
                }
                .listRowBackground(moim.theme.mainColor)
            }
            .onDelete { indices in
                // 나중에 삭제하기전에 물어보게하자.
                //아니면 디테일 화면 안에서 삭제 가능하게.
                moims.remove(atOffsets: indices)
            }
            
            
        }
        .navigationTitle("Moims")
        .toolbar {
            Button(action: {
                isPresentingNewMoimView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewMoimView) {
            NavigationView {
                MoimEditView(data: $newMoimData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewMoimView = false
                                newMoimData = Moim.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newMoim = Moim(data: newMoimData)
                                moims.append(newMoim)
                                isPresentingNewMoimView = false
                                newMoimData = Moim.Data()
                            }
                        }
                        
                    }
            }
            
        }
    }
    
}

struct MoimsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoimsView(moims: .constant(Moim.sampleData))
        }
    }
}
