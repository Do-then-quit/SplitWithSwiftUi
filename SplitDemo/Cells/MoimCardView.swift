//
//  MoimCardView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

struct MoimCardView: View {
    let moim: Moim
    var body: some View {
        VStack(alignment: .leading) {
            Text(moim.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(moim.attendees.count)", systemImage: "person.3")
                Spacer()
                Label("\(moim.tempTotalSobi)", systemImage: "dollarsign")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(moim.theme.accentColor)
    }
}

struct MoimCardView_Previews: PreviewProvider {
    static var moim = Moim.sampleData[0]
    static var previews: some View {
        MoimCardView(moim: moim)
            .background(moim.theme.mainColor)
            .previewLayout(.fixed(width: 400.0, height: 60))
    }
}
