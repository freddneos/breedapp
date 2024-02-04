//
//  DogBreedView.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 04/02/2024.
//

import SwiftUI

struct DogBreedView: View {
    let breed: DogBreed
    var isGridView: Bool
    
    var body: some View {
        if isGridView {
            VStack {
                AsyncImage(url: breed.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 165, height: 165)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                TextDescription(breed:breed)
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(radius: 2)
            .padding(5)
        } else {
            HStack {
                AsyncImage(url: breed.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(breed.name)
                        .bold()
                    Text(breed.lifeSpan)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    // TODO: implement the navigation to details screen
                }) {
                    Image(systemName: "arrow.right.circle")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct TextDescription: View {
    let breed: DogBreed
    
    var body: some View {
        VStack {
            VStack{
                Text(breed.name)
                    .bold()
                    .font(.caption)
                    .foregroundColor(.black)
                Text(breed.lifeSpan)
                    .font(.caption)
                    .foregroundColor(.black)
                Spacer(minLength: 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        

    }
}

#Preview {
    TabNavigationView()
}
