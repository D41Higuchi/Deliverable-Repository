//
//  PopView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/12/05.
//

import SwiftUI

struct PopView: View {
    @Binding var selectStr: String
    var body: some View {
        Text("\(selectStr)が\n登録されました。")
                   .frame(width: 250, height: 70)
                   .foregroundColor(.black)
                   .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.8))
                   .cornerRadius(10)
    }
}

struct PopView_Previews: PreviewProvider {
    @State static var selectStr = ""
    static var previews: some View {
        PopView(selectStr: $selectStr)
    }
}
