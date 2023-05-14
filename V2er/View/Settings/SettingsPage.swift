//
//  SettingsPage.swift
//  SettingsPage
//
//  Created by Seth on 2021/8/3.
//  Copyright © 2021 lessmore.io. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    @Environment(\.dismiss) var dismiss

    @State var logingOut: Bool = false

    var body: some View {
        formView
            .navBar("设置")
    }

    @ViewBuilder
    private var formView: some View {
        ScrollView {
            VStack(spacing: 0) {
                SectionItemView("通用设置", showDivider: false)
                    .padding(.top, 8)
                    .to { OtherSettingsView() }
                Button {
                    "https://www.v2ex.com/help".openURL()
                } label: {
                    SectionItemView("帮助与反馈")
                        .padding(.top, 8)
                }
                Button {
                    "https://github.com/v2er-app".openURL()
                } label: { SectionItemView("源码开放") }
                Button {
                    "https://v2er.app".openURL()
                } label: {
                    SectionView("关于") {
                        HStack {
                            Text("版本1.0.0")
                                .font(.footnote)
                                .foregroundColor(Color.tintColor)
                            Image(systemName: "chevron.right")
                                .font(.body.weight(.regular))
                                .foregroundColor(.gray)
                                .padding(.trailing, 16)
                        }
                    }
                }

//                Button {
//                    // go to app store
//                } label: {
//                    SectionItemView("给V2er评分", showDivider: false)
//                }
//                .hide()

                Button {
                    // go to app store
                    withAnimation {
                        logingOut = true
                    }
                } label: {
                    SectionItemView("退出登录", showDivider: false)
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }
                .confirmationDialog(
                    "登出吗?",
                    isPresented: $logingOut,
                    titleVisibility: .visible
                ) {
                    Button("确定", role: .destructive) {
                        withAnimation {
                            logingOut = false
                        }
                        AccountState.deleteAccount()
                        Toast.show("已登出")
                        dismiss()
                    }
                }

            }
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
