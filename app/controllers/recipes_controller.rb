require "open-uri"

class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
    @recipes = policy_scope(Recipe)
    .select('DISTINCT ON (recipes.name) recipes.*')
    .order('recipes.name')

    @categories = []
    @recipes.each do |recipe|
      recipe.name = clean_recipe_name(recipe.name)
      recipe.save
      @categories << recipe.category unless @categories.include?(recipe.category)
    end

    if params[:query].present?
      @recipes = @recipes.search_by_name_desc_cat(params[:query])
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe.name = clean_recipe_name(@recipe.name)
    @meal_day = MealDay.new
    authorize @recipe
    @ingredients = @recipe.ingredients
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.photo.blank?
      photo_url = "https://source.unsplash.com/random/?#{@recipe.name}"
      photo = URI.open(photo_url)
      @recipe.photo.attach(io: photo, filename: "#{@recipe.name.split().join("_")}.png", content_type: "image/png")
    end
    if @recipe.save!
      Favorite.create(user: current_user, recipe: @recipe)
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      render :new, status: :unprocessable_entity, notice: "Fill the form correctly dummy"
      redirect_to(root_path)
    end
    authorize @recipe
  end

  private

  def params_recipe
    params.require(:recipe).permit(:name, :description, :prep_time, :rating, :servings, :category, :photo)
  end

  def clean_recipe_name(name)
    checks = ["Recipes", "Recipe", "recipe", "recipes"]
    name = name.split(":")[-1] if name.include?(":")
    checks.each do |check|
      if name.include?(check)
        name = name.gsub(check, "")
      end
    end
    return name
  end
end
