import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                if let imagePath = recipe.image {
                    Image.fromPath(imagePath: imagePath)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(5)
                }
                
                Text(recipe.title)
                    .font(.largeTitle)
                    .padding()
                
                VStack {
                    HStack {
                        Text("Calories:")
                            .bold()
                        Spacer()
                        Text("\(recipe.calories, specifier: "%.1f")")
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("Total Weight:")
                            .bold()
                        Spacer()
                        Text("\(recipe.totalWeight, specifier: "%.1f")")
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("Type:")
                            .bold()
                        Spacer()
                        Text(recipe.type)
                    }
                    .padding(.vertical, 5)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                
                if recipe.ingredients.count > 0 {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.top)
                    VStack(alignment: .leading) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack {
                                Text("- \(ingredient)")
                                    .padding(.vertical, 4)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
                Text("Date Added: \(recipe.dateAdded, formatter: DateFormatter.shortDateFormatter)")
                    .foregroundStyle(.secondary)
                    .padding(.top)
            }
            .padding()
        }
    }
}
