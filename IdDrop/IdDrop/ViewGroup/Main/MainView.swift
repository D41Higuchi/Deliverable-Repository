//
//  MainView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/05.
//

import SwiftUI
import Neumorphic


//アセットカラーの設定
struct MyColor {
    static let MainColor = Color("MainColor")
    static let LightShadow = Color("LightShadow")
    static let DarkShadow = Color("DarkShadow")
    static let TextColor = Color("TextColor")
    static let HighlightColor = Color("HighlightColor")
}

//画面サイズ取得
let screen = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

//タブアイコンのコンポーネント
struct TabItem<Tab>: View where Tab: Equatable {
    let image: Image
    let tab: Tab
    var mainColor: Color = MyColor.MainColor
    var darkShadowColor: Color = MyColor.DarkShadow
    var lightShadowColor: Color = MyColor.LightShadow
    @Binding var selected: Tab
    
    var body: some View {
//        選択タブ
        if tab == selected {
            VStack {
                image
                    .resizable()
                    .frame(width: screen * 0.09 , height: screen * 0.08)
                    .foregroundColor(MyColor.HighlightColor)
            }
            .frame(width: screen * 0.07, height: screen * 0.07)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                        .fill(mainColor)
                        .softInnerShadow(
                            RoundedRectangle(cornerRadius: 10),
                            darkShadow: darkShadowColor,
                            lightShadow: lightShadowColor,
                            spread: 0.05,
                            radius: 2
                        )
            )
//            非選択タブ
        } else {
            VStack {
                image
                    .resizable()
                    .frame(width: screen * 0.07 , height: screen * 0.06)
                    .foregroundColor(MyColor.TextColor)
            }
            .frame(width: screen * 0.07, height: screen * 0.07)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(mainColor)
                    .softOuterShadow()
            )
            .onTapGesture {
                selected = tab
            }
        }
    }
}


struct MainView: View {
    @State var selectedTab = Tab.home
        
        enum Tab: Int {
            case home, management
//            , settings
        }
        
        var body: some View {
            ZStack {
                MyColor.MainColor.ignoresSafeArea()
                TabView(selection: $selectedTab) {
                    HomeView().tag(Tab.home)
                    managementView().tag(Tab.management)
//                    SettingView().tag(Tab.settings)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                VStack {
                    Spacer(minLength: 0)
                    
                    HStack {
                        Spacer()
                        TabItem(
                            image: Image(systemName: "house.fill"),
                            tab: Tab.home,
                            selected: $selectedTab
                        )
                        Spacer()
                        
                        TabItem(
                            image: Image(systemName: "waveform.badge.plus"),
                            tab: Tab.management,
                            selected: $selectedTab
                        )
//                        Spacer()
//
//                        TabItem(
//                            image: Image(systemName: "list.bullet"),
//                            tab: Tab.settings,
//                            selected: $selectedTab
//                        )
                        Spacer()
                        
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .padding(.bottom , 15)

                    .background(
                        RoundedRectangle(cornerRadius: 10).fill(MyColor.MainColor)
                    )
                    
                }
            }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(snsClass())
    }
}
