class MealDaysController < ApplicationController
  def index
    @meal_days = policy_scope(MealDay)
    @meal_days = current_user.meal_days
    @grocery = Grocery.new
    @favorites = user_signed_in? ? Recipe.where(favorites: current_user.favorites) : []
  end

  def create
    # raise
    @recipe = Recipe.find(params[:recipe_id])
    @meal_day = MealDay.new(meal_day_params)
    # @meal_day.save
    @meal_day.recipe = @recipe
    @meal_day.user = current_user
    # @meal_day.grocery = Grocery.first

    if @meal_day.save!
      # if params[:refresh_to].present?
      #   redirect_to params[:refresh_to]
      # else
      redirect_to meal_days_path
      # end
    else
      render "recipes/show", status: :unprocessable_entity
    end
    authorize @meal_day
  end

  def destroy
    @meal_day = MealDay.find(params[:id])
    @meal_day.destroy
    authorize @meal_day
    redirect_to params[:refresh_to]
  end

  private

  def meal_day_params
    attributes = params.require(:meal_day).permit(:date, :quantity)
    attributes[:date] = Date.iso8601(attributes[:date])
    attributes[:quantity] = attributes[:quantity].to_i
    attributes
  end
end
