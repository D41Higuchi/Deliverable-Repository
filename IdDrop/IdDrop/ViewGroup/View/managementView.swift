//
//  managementView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/05.
//

import SwiftUI
import Neumorphic
import PhotosUI

class set: ObservableObject {
    @AppStorage("key.setInstagram") var setInstagram:String = "未登録"
    @AppStorage("key.setTwitter") var setTwitter:String  = "未登録"
    @AppStorage("key.setLine") var setLine:String  = "未登録"
    @AppStorage("key.setTiktok") var setTiktok:String  = "未登録"
    @AppStorage("key.setFacebook") var setFacebook:String  = "未登録"
}

struct managementView: View {
    //クラスのインスタンス化
    @EnvironmentObject var snsClass: snsClass
    @EnvironmentObject var set: set
    
    //画面サイズの取得
    let screen = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var showingAlert = false
    
    //モーダル遷移用
    @State var isShowDialog = false
    @State var isShowSelectDialog = false
    @State var selectSnsName = ""

    @State var sheet = false
    @State  var isModal = false
    
    //photoPicer
    @State var photoPickerItems: [PhotosPickerItem] = []
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        
        ZStack{
            //背景色の設定
            MyColor.MainColor
                .ignoresSafeArea()
            
            //縦要素
            VStack{
                //トップ
                HStack{
                    Image("SnsText")
                        .resizable()
                        .aspectRatio(1 / 0.643, contentMode: .fit)
                        .frame(width: screen * 0.34)
                        .padding(.top, screen * 0.02)
                        .padding(.leading, screen * 0.1)
                        .padding(.bottom, screen * 0.05)
                    Spacer()
                }
                
                //contents
                ZStack{
                    
                    RoundedRectangle(cornerRadius:60)
                        .fill(MyColor.MainColor)
                        .softOuterShadow()
                        .frame(width: screen * 0.9, height: screenHeight * 0.6)
                    
                    VStack{
                        ZStack{
                            VStack{
                                Group{
                                    Divider()
                                    HStack{
                                        Image("instagram")
                                            .resizable()
                                            .frame(width:screen*0.06, height:screen*0.06)
                                        Text("Instagram")
                                            .foregroundColor(MyColor.TextColor)
                                        Spacer()
                                        
                                        switch set.setInstagram {
                                        case "登録済み":
                                            Text(set.setInstagram )
                                                .foregroundColor(MyColor.HighlightColor)
                                        default:
                                            Text(set.setInstagram )
                                                .foregroundColor(MyColor.TextColor)
                                        }                                    }
                                    Divider()
                                    HStack{
                                        Image("twiiter")
                                            .resizable()
                                            .frame(width:screen*0.06, height:screen*0.06)
                                        Text("Twitter")
                                            .foregroundColor(MyColor.TextColor)
                                        Spacer()
    
                                        switch set.setTwitter {
                                        case "登録済み":
                                            Text(set.setTwitter)
                                                .foregroundColor(MyColor.HighlightColor)
                                        default:
                                            Text(set.setTwitter)
                                                .foregroundColor(MyColor.TextColor)
                                        }
                                    }
                                    Divider()
                                }
                                Group{
                                    HStack{
                                        Image("line")
                                            .resizable()
                                            .frame(width:screen*0.06, height:screen*0.06)
                                        Text("Line")
                                            .foregroundColor(MyColor.TextColor)
                                        Spacer()
                                        switch set.setLine {
                                        case "登録済み":
                                            Text(set.setLine)
                                                .foregroundColor(MyColor.HighlightColor)
                                        default:
                                            Text(set.setLine)
                                                .foregroundColor(MyColor.TextColor)
                                        }
                                    }
                                    Divider()
                                    HStack{
                                        Image("tiktok")
                                            .resizable()
                                            .frame(width:screen*0.06, height:screen*0.06)
                                        Text("TikTok")
                                            .foregroundColor(MyColor.TextColor)
                                        Spacer()
                                        
                                        switch set.setTiktok {
                                        case "登録済み":
                                            Text(set.setTiktok)
                                                .foregroundColor(MyColor.HighlightColor)
                                        default:
                                            Text(set.setTiktok)
                                                .foregroundColor(MyColor.TextColor)
                                        }
                                    }
                                    Divider()
                                    HStack{
                                        Image("facebook")
                                            .resizable()
                                            .frame(width:screen*0.06, height:screen*0.06)
                                        Text("FaceBook")
                                            .foregroundColor(MyColor.TextColor)
                                        Spacer()
                                        
                                        switch set.setFacebook {
                                        case "登録済み":
                                            Text(set.setFacebook)
                                                .foregroundColor(MyColor.HighlightColor)
                                        default:
                                            Text(set.setFacebook)
                                                .foregroundColor(MyColor.TextColor)
                                        }
                                    }
                                    Divider()
                                }
                            }
                            .frame(width: screen * 0.65, height: screenHeight * 0.3)
                        }
                        
                        Button(action: {}) {
                            HStack{
                                Image("change")
                                    .resizable()
                                    .frame(width: screen * 0.06, height: screen * 0.06)
                                    .padding(.trailing, screen * 0.01)
                                
                                Button(action: {
                                    isModal.toggle()
                                }, label: {
                                    HStack{
                                        Text("SNSを変更する")
                                            .foregroundColor(MyColor.HighlightColor)
                                    }
                                })
                                //表示するビュー
                                .sheet(isPresented: $isModal, content: {
                                    ModalView()
                                        .presentationDetents([.medium])
                                })
                            }
                            .padding(.horizontal, screen * 0.1)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        .padding()
                        .padding(.top , screenHeight * 0.02)
                             
                        //Delete
                        Button(action: {
                            isShowSelectDialog = true
                        }) {
                            HStack{
                                Image("delete")
                                    .resizable()
                                    .frame(width: screen * 0.05, height: screen * 0.06)
                                    .padding(.trailing, screen * 0.01)
                                
                                Text("SNSを削除する")
                                    .foregroundColor(Color.red)
                            }
                            .padding(.horizontal, screen * 0.1)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        .controlSize(.large)
                        .confirmationDialog("SNSを選択してください", isPresented: $isShowSelectDialog, titleVisibility: .visible) {
                            Button("Instagram"){
                                selectSnsName = "Instagram"
                                self.showingAlert = true
                            }
                            Button("Twitter"){
                                selectSnsName = "Twitter"
                                self.showingAlert = true
                            }
                            Button("Line"){
                                selectSnsName = "Line"
                                self.showingAlert = true
                            }
                            Button("TikTok"){
                                selectSnsName = "TikTok"
                                self.showingAlert = true
                            }
                            Button("FaceBook"){
                                selectSnsName = "FaceBook"
                                self.showingAlert = true
                            }
                            Button("キャンセル", role: .cancel){
                            }
                        }
                        .alert("警告", isPresented: $showingAlert){
                            Button("解除", role: .destructive){
                                //url情報の初期化
                                switch selectSnsName {
                                case "Instagram":
                                    snsClass.InstagramUrl = ""
                                    set.setInstagram = "未登録"
                                    
                                case "Twitter":
                                    snsClass.TwitterUrl = ""
                                    set.setTwitter = "未登録"
                                    
                                case "Line":
                                    snsClass.LineUrl = ""
                                    set.setLine = "未登録"
                                
                                case "TikTok":
                                    snsClass.TiktokUrl = ""
                                    set.setTiktok = "未登録"
                                    
                                case "FaceBook":
                                    snsClass.FacebookUrl = ""
                                    set.setFacebook = "未登録"
                                default:
                                    break
                                }
                            }
                        } message: {
                            Text("\(selectSnsName)を登録解除しますか？")
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct managementView_Previews: PreviewProvider {
    static var previews: some View {
        managementView()
            .environmentObject(snsClass())
    }
}
