//
//  TabbarView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        HStack(spacing: 60) {
            ForEach(viewModel.tabItems) { item in
                Button {
                    viewModel.selectTab(item)
                } label: {
                    HStack(spacing: 12) {
                        Image(item.iconName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .opacity(viewModel.selectedTab == item ? 1 : 0.5)
                        
                        Text(item.title)
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundStyle(viewModel.selectedTab == item ? .white.opacity(0.9) : .white.opacity(0.5))
                    }
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.purple, .indigo, .blue]),
                    startPoint: .leading, endPoint: .trailing
                ))
                .frame(width: 370, height: 70)
                .shadow(color: .primary.opacity(0.2), radius: 5.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.white.opacity(0.6), .clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
        }
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.white.opacity(0.88), .colorText.opacity(2)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .frame(width: 400, height: 80)
                .offset(y: 30)
        )
    }
}

#Preview {
    CustomTabBarView(viewModel: TabBarViewModel())
}
