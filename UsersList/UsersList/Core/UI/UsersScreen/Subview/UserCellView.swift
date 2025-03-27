//
//  UserCellView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct UserCellView: View {
    @ObservedObject var viewModel: UsersViewModel
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: user.avatar)) { image in
                image.resizable()
            } placeholder: {
                ProgressView().scaleEffect(0.8)
            }
            .scaledToFill()
            .frame(width: 72, height: 72)
            .clipShape(Circle())
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 6) {
                
//                Text("\(user.firstName) \(user.lastName)")
                Text(user.firstName + " " + user.lastName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Text(verbatim: user.email)
                    .font(.subheadline)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            
            VStack {
                Button {
                    viewModel.toggleFavorite(user: user)
                } label: {
                    Image(viewModel.isFavorite(user: user) ? Icons.bookmarkDelIcon : Icons.bookmarkAddIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .primary.opacity(0.2), radius: 5.0)
        .padding(.horizontal)
    }
}

#Preview {
    UserCellView(viewModel: UsersViewModel(), user: User.usersPreview[0])
}
