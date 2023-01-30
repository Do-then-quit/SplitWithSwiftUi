//
//  MoimEditView.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

struct MoimEditView: View {
    @Binding var data: Moim.Data
    @State private var newAttendeeName = ""

    var body: some View {
        Form {
            Section(header: Text("Moim Info")) {
                TextField("Title", text: $data.title)
                
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = Moim.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct MoimEditView_Previews: PreviewProvider {
    static var previews: some View {
        MoimEditView(data: .constant(Moim.sampleData[0].data))
    }
}
