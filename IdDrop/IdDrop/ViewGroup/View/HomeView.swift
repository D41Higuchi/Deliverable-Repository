//
//  HomeView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/04.
//

import SwiftUI
import Neumorphic
//snsのクラス(AppStorage)
class snsClass: ObservableObject {
    @AppStorage("key.instagram") var InstagramUrl = ""
    @AppStorage("key.twitter") var TwitterUrl = ""
    @AppStorage("key.line") var LineUrl = ""
    @AppStorage("key.tiktok") var TiktokUrl = ""
    @AppStorage("key.facebook") var FacebookUrl = ""
}
//URLの有効性チェック関数
func validationUrl (_ urlStr: String) -> Bool {
    guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
        return false
    }
    if let url = NSURL(string: encurl) {
        return UIApplication.shared.canOpenURL(url as URL)
    }
    return false
}

struct HomeView: View {
    //クラスのインスタンス化
    @EnvironmentObject var snsClass: snsClass
    
    @State var isShowDialog = false
    @State var ShowSharePopover: Bool = false
    
    @State var selectSnsName = "Select your SNS"
    //アラート用
    @State var showingAlertNil = false
    
    //画面サイズ取得
    let screen = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

//------------------------------------------------------------------//
    var body: some View {
        ZStack{
            //背景色の設定
            MyColor.MainColor
                .ignoresSafeArea()
            
            //縦要素
            VStack{
                //トップ
                HStack(spacing: screen * 0.13){
                    Image("IdDropText")
                        .resizable()
                        .aspectRatio(1 / 0.377, contentMode: .fit)
                        .frame(width: screen * 0.55)
                        .padding(.top , screen * 0.01)
                    
                    Button(action: {}) {
                        Image("qusetion")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(1 / 1, contentMode: .fit)
                            .frame(width: screen * 0.08)
                    }
                    .softButtonStyle(Capsule(), pressedEffect: .hard)
                }
                .padding(.top)
                
                Spacer()
                
                //選択ボタン
                ZStack{
                    RoundedRectangle(cornerRadius:screen * 0.13)
                        .fill(MyColor.MainColor)
                        .softOuterShadow()
                        .aspectRatio(3 / 4.2, contentMode: .fit)
                        .frame(width: screen * 0.83)
                    
                    VStack{
                        VStack {
                            HStack{
                                Text(selectSnsName)
                                    .foregroundColor(MyColor.TextColor)
                                    .padding(.leading, screen * 0.15)
                                    .font(.title2)
                                Spacer()
                                
                                Button(action: {
                                    isShowDialog = true
                                }) {
                                    Image("Icon awesome-chevron-down")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(1 / 1, contentMode: .fit)
                                        .frame(width: screen * 0.07)
                                        .padding(.trailing,  screen * 0.15)
                                }
                                .controlSize(.large)
                                .confirmationDialog("SNSを選択してください", isPresented: $isShowDialog, titleVisibility: .visible) {
                                    Button("Instagram"){
                                        selectSnsName = "Instagram"
                                    }
                                    Button("Twitter"){
                                        selectSnsName = "Twitter"
                                    }
                                    Button("Line"){
                                        selectSnsName = "Line"
                                    }
                                    Button("TikTok"){
                                        selectSnsName = "TikTok"
                                    }
                                    Button("FaceBook"){
                                        selectSnsName = "FaceBook"
                                    }
                                    Button("キャンセル", role: .cancel){
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.Neumorphic.main)
                                    .softInnerShadow(RoundedRectangle(cornerRadius: 10), darkShadow: MyColor.DarkShadow, lightShadow: MyColor.LightShadow, spread: 0.05, radius: 2)
                                    .frame(width: screen * 0.7 , height: screen * 0.14)
                            )
                            .padding(.bottom, screen * 0.04)
                        }
                        .padding()
                        
                        //shareアクションボタン
                        Button(action: {
                            
                            switch selectSnsName {
                            case "Instagram":
                                if snsClass.InstagramUrl.isEmpty{
                                    showingAlertNil = true
                                }else{
                                    Share(shareText: selectSnsName, shareUrl: snsClass.InstagramUrl)
                                }
                            case "Twitter":
                                if snsClass.TwitterUrl.isEmpty{
                                    showingAlertNil = true
                                }else{
                                    Share(shareText: selectSnsName, shareUrl: snsClass.TwitterUrl)
                                }
                            case "Line":
                                if snsClass.LineUrl.isEmpty{
                                    showingAlertNil = true
                                }else{
                                    Share(shareText: selectSnsName, shareUrl: snsClass.LineUrl)
                                }
                            case "TikTok":
                                if snsClass.TiktokUrl.isEmpty{
                                    showingAlertNil = true
                                }else{
                                    Share(shareText: selectSnsName, shareUrl: snsClass.TiktokUrl)
                                }
                            case "FaceBook":
                                if snsClass.FacebookUrl.isEmpty{
                                    showingAlertNil = true
                                }else{
                                    Share(shareText: selectSnsName, shareUrl: snsClass.FacebookUrl)
                                }
                                    
                            default:
                                break
                            }
                        }
                               
                        ) {
                            Image("IdDrop")
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(1 / 1, contentMode: .fit)
                                .frame(width: screen * 0.65)
                        }
                        .softButtonStyle(Capsule(), mainColor: MyColor.MainColor, pressedEffect: .hard)
                        .alert(isPresented: $showingAlertNil) {
                            Alert(title: Text("未登録"),
                                  message: Text("このSNSはまだ登録されていません。")
                            )
                        }
                    }
                }
                Spacer(minLength: screenHeight * 0.17)
            }
        }
    }
    
    
    func Share(shareText: String, shareUrl: String) {
            let activityItems = [shareText, URL(string: shareUrl)!] as [Any]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let viewController = windowScene?.windows.first?.rootViewController
            viewController?.present(activityVC, animated: true)
        }
}


//プレビュー
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(snsClass())
    }
}
