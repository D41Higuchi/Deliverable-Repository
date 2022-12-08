//
//  subView.swift
//  Sample
//
//  Created by dai.higuchi on 2022/07/06.
//

import SwiftUI
import Neumorphic

struct subView: View {
    var body: some View {
        VStack{
        }
    }
}



struct ShareView: UIViewControllerRepresentable {
func makeUIViewController(context: Context) -> UIActivityViewController {
    let link = URL(string: "https://qiita.com/SNQ-2001/items/86646b661ccc4a7a9034")!
    let activityViewController = UIActivityViewController( activityItems: [link], applicationActivities: nil)
    return activityViewController
}
func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
}


struct subView_Previews: PreviewProvider {
    static var previews: some View {
        subView()
    }
}
}
