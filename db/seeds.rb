
require "json"
require "open-uri"

cuisine_types = [
  "Mexican",
  "Asian",
  "British",
  "Caribbean",
  "Chinese",
  "Indian",
  "Italian",
  "Nordic",
  "Mediterranean"
]


puts "let's populate the databases !"

cuisine_types.each do |type|
  url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=#{ENV.fetch("EDAMAN_APP_ID")}&app_key=#{ENV.fetch("EDAMAN_APP_KEY")}&cuisineType=#{type}&mealType=Dinner"
  file = URI.open(url).read
  data = JSON.parse(file)
  puts "starting with #{type} recipes"

  data["hits"].each do |hit|
    recipe = Recipe.create!(
      name: hit["recipe"]["label"],
      description: hit["recipe"]["ingredientLines"].join("\n"),
      prep_time: hit["recipe"]["totalTime"].to_i > 0 ? hit["recipe"]["totalTime"].to_i : [15, 30, 45, 60].sample,
      rating: (1..5).to_a.sample,
      servings: hit["recipe"]["yield"].to_i,
      category: type
    )
    puts "creating ingredients for #{recipe.name}"
    hit["recipe"]["ingredients"].each do |ingredient|
      Ingredient.create!(
        name: ingredient["food"],
        quantity: ingredient["quantity"],
        unit: ingredient["measure"].blank? ? "N.A" : ingredient["measure"],
        recipe_id: recipe.id
      )
    end
  end
end

puts "done!"
