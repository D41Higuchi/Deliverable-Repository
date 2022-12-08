//
//  SettingView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/05.
//

import SwiftUI
import Neumorphic


struct SettingView: View {
    //    画面サイズの取得
    let screen = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            //背景色の設定
            MyColor.MainColor
                .ignoresSafeArea()
            
            //            縦要素
            VStack{
                //                トップ
                HStack{
                    Image("AccountText")
                        .resizable()
                        .aspectRatio(1 / 0.342, contentMode: .fit)
                        .frame(width: screen * 0.65)
                        .padding(.top, screen * 0.02)
                        .padding(.leading, screen * 0.05)
                        .padding(.bottom, screen * 0.04)
                    
                    
                    Spacer()
                }
                
                //                contents
                ZStack{
                    RoundedRectangle(cornerRadius:40)
                        .fill(MyColor.MainColor)
                        .softOuterShadow()
                        .frame(width: screen * 0.9, height: screenHeight * 0.6)
                    
                    //RoundedRectangle(cornerRadius:60)
                    //.fill(MyColor.MainColor)
                    //softOuterShadow()
                    //.aspectRatio(3 / 4.3, contentMode: .fit)
                    //.frame(width: screen * 0.9)
                    
                    VStack{
                        
                        Button(action: {}) {
                            Text("アカウント編集")
                                .foregroundColor(MyColor.TextColor)
                                .frame(width: screen * 0.65)
                            
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        //                        .padding(screen * 0.03)
                        .padding(screenHeight * 0.018)
                        
                        Button(action: {}) {
                            
                            Text("SNSアカウントを増やす")
                                .foregroundColor(MyColor.TextColor)
                                .frame(width: screen * 0.65)
                            
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        .padding(screen * 0.018)
                        
                        Button(action: {}) {
                            
                            Text("お問い合わせ")
                                .foregroundColor(MyColor.TextColor)
                                .frame(width: screen * 0.65)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        //                        .padding(screen * 0.03)
                        .padding(screenHeight * 0.018)
                        
                        Button(action: {}) {
                            
                            Text("プライバシーポリシー")
                                .foregroundColor(MyColor.TextColor)
                                .frame(width: screen * 0.65)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        //                        .padding(screen * 0.03)
                        .padding(screenHeight * 0.018)
                        
                        Button(action: {}) {
                            
                            Text("利用規約")
                                .foregroundColor(MyColor.TextColor)
                                .frame(width: screen * 0.65)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10),padding: screen * 0.035, mainColor: MyColor.MainColor)
                        //                        .padding(screen * 0.03)
                        .padding(screenHeight * 0.018)
                        
                        
                    }
                }
                Spacer()
                
                
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
