//
//  ModalView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/10/22.
//

import SwiftUI
import Neumorphic
import PhotosUI

struct ModalView: View {
    //各urlの保存
    func InputURL(urlString: String) {
        if urlString.contains("instagram.com") {
            snsClass.InstagramUrl = urlString
            selectStr = str[0]
            set.setInstagram = "登録済み"
            return
        }
        if urlString.contains("twitter.com") {
            snsClass.TwitterUrl = urlString
            selectStr = str[1]
            set.setTwitter = "登録済み"
            return
        }
        if urlString.contains("line.me") {
            snsClass.LineUrl = urlString
            selectStr = str[2]
            set.setLine = "登録済み"
            return
        }
        if urlString.contains("tiktok.com") {
            snsClass.TiktokUrl = urlString
            selectStr = str[3]
            set.setTiktok = "登録済み"
            return
        }
        if urlString.contains("facebook.com") {
            snsClass.FacebookUrl = urlString
            selectStr = str[4]
            set.setFacebook = "登録済み"
            return
        }else{
            showingSetError = true
        }
    }
    
    //写真を選択してphotoPickerItemsが変わったら呼び出されるメソッド
    func action(equatable: any Equatable) {
        guard let items = equatable as? [PhotosPickerItem] else {
            return
        }
        Task {
            for item in items {
                //PhotosPickerItemをUIImage型に変換します。
                guard let data = try? await item.loadTransferable(type: Data.self),
                      let image = UIImage(data: data) else {
                    continue
                }
                //UIImageからQRコードを検出
                //QRコードが検出できない場合はfeatures配列は要素数が0
                let features = detectQRCode(image)
                for feature in features {
                    //QRコードが正しく検出できたらmessageStringにURLが入っているはず
                    print(feature.messageString ?? "nope") // https://jingged.com
                    QRStr = feature.messageString
                }
            }
        }
    }
    
    // ***** UIImageからQRコードを検出するメソッド
    func detectQRCode(_ image: UIImage?) -> [CIQRCodeFeature] {
        guard let image = image,
              let ciImage = CIImage(image: image) else {
            return []
        }
        let context = CIContext()
        let options1: [String : Any] = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        guard let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options1) else {
            return []
        }
        let options2: [String : Any] = ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)) ?
        [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1] :
        [CIDetectorImageOrientation: 1]
        let features = qrDetector.features(in: ciImage, options: options2)
        let qrCodeFeatures = features.compactMap({ $0 as? CIQRCodeFeature })
        return qrCodeFeatures
    }
    @State var QRStr: String?
    
    //sns識別ポップアップ用変数
    @State var showingSetAlert = false
    @State var showingSetError = false
    
    @State var str = ["Instagram","Twitter","Line","TikTok","FaceBook"]
    @State var selectStr = ""
    
    //modalを閉じる変数
    @Environment(\.dismiss) var dismiss
    
    //クラスのインスタンス化
    @EnvironmentObject var snsClass: snsClass
    @EnvironmentObject var set: set
    
    
    //画像
    @State var photoPickerItems: [PhotosPickerItem] = []
    
    @State var urlString = ""
    //-----------------------------------------------------------------------------
    var body: some View {
        ZStack{
            //背景色の設定
            MyColor.MainColor
                .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius:screen * 0.03)
                        .fill(MyColor.MainColor)
                        .softOuterShadow()
                        .aspectRatio(100 / 20, contentMode: .fit)
                        .frame(width: screen * 0.8)
                    
                    //QR画像選択
                    PhotosPicker(
                        selection: $photoPickerItems,
                        maxSelectionCount: 1, // 選択する写真の数(0で無制限)
                        selectionBehavior: .ordered, // 順番が関係するか
                        matching: .images, // 写真の種類を選択(nilでどれでも可に)
                        preferredItemEncoding: .current, // エンコードの種類(基本currentでいいはず)
                        photoLibrary: .shared()){ // ライブラリの選択
                            
                            Text("QRコードを読み込む")
                                .foregroundColor(MyColor.HighlightColor)
                        }
                        .onChange(of: photoPickerItems, perform: action)
                        .onChange(of: QRStr) {newValue in
                            urlString = QRStr ?? ""
                            
                            InputURL(urlString: urlString)
                            
                            withAnimation(.easeIn(duration: 0.3)) {
                                if selectStr.isEmpty {
                                    
                                }else{
                                    showingSetAlert = true
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.easeOut(duration: 0.1)) {
                                    showingSetAlert = false
                                    dismiss()
                                }
                            }
                        }
                        .alert("\(selectStr)が\n登録されました。", isPresented: $showingSetAlert) {
                        }
                        .alert("無効なURL", isPresented: $showingSetError) {
                        }message: {
                            Text("URLを再入力してください。")
                        }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius:screen * 0.04)
                        .fill(MyColor.MainColor)
                        .softOuterShadow()
                        .aspectRatio(100 / 40, contentMode: .fit)
                        .frame(width: screen * 0.8)
                    
                    VStack {
                        Text("URLを読み込む")
                            .foregroundColor(MyColor.HighlightColor)
                        
                        HStack{
                            TextField("URL....", text: $urlString)
                                .foregroundColor(MyColor.TextColor)
                                .autocapitalization(.none)
                            
                            //ペーストボタン
                            Button(action: {
                                //クリップボードのnil判定処理
                                if ((UIPasteboard.general.string) != nil) {
                                    urlString = UIPasteboard.general.string!
                                }
                            }){
                                Image(systemName: "doc.on.clipboard")
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(MyColor.MainColor)
                                .softInnerShadow(RoundedRectangle(cornerRadius: 30),
                                                 darkShadow: MyColor.DarkShadow,
                                                 lightShadow: MyColor.LightShadow,
                                                 spread: 0.14, radius: 2)
                                .frame(width: screen * 0.75)
                        )
                        
                    }
                    .padding( screen * 0.15)
                    
                }
                
                Button(action: {
                    
                    InputURL(urlString: urlString)
                    
                    withAnimation(.easeIn(duration: 0.3)) {
                        if selectStr.isEmpty {
                            
                        }else{
                            showingSetAlert = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeOut(duration: 0.1)) {
                            showingSetAlert = false
                            dismiss()
                        }
                    }
                }) {
                    Text("確定")
                        .foregroundColor(MyColor.HighlightColor)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 15),
                                 pressedEffect: .flat)
                
                .alert("\(selectStr)が\n登録されました。", isPresented: $showingSetAlert) {
                }
                .alert("無効なURL", isPresented: $showingSetError) {
                }message: {
                    Text("URLを再入力してください。")
                }
                Spacer()
            }
        }
    }
}


struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
            .environmentObject(snsClass())
        
    }
}
