//
//  UserDetailsScreen.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct UserDetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UsersViewModel
    
    let user: User
    let support: Support? = nil
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                HStack(spacing: 20) {
                    AsyncImage(url: URL(string: user.avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView().scaleEffect(0.8)
                    }
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        Text(user.firstName + " " + user.lastName)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                        
                        Text(verbatim: user.email)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.colorText).opacity(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.purple.opacity(0.2), .blue.opacity(0.12)]),
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .shadow(color: .white.opacity(0.9), radius: 10.0)
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.toggleFavorite(user: user)
                    } label: {
                        Image(viewModel.isFavorite(user: user) ? Icons.bookmarkDelIcon : Icons.bookmarkAddIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .shadow(color: .purple.opacity(0.8), radius: 2.0)
                    }
                }
                .padding()
            }
            
            Text(verbatim: viewModel.support?.text ?? "No Data")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.gray)
                .padding()
            
            Spacer()
            
        }
        .backgroundGradient()
//        .navigationTitle("User Details")
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    UserDetailsScreen(viewModel: UsersViewModel(), user: User.usersPreview[0])
}
