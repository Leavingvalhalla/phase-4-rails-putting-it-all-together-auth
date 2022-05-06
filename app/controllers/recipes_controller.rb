class RecipesController < ApplicationController

    def index
        if session.include? :user_id
            render json: Recipe.all, include: :user, status: :created
        else
            render json: {errors: ['Log in to look at recipes']}, status: :unauthorized
        end
    end

    def create
        if session.include? :user_id
            recipe_hash = {title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: session[:user_id]}
            recipe = Recipe.new(recipe_hash)
            if recipe.valid?
                recipe.save
                render json: recipe, include: :user, status: :created
            else
                render json: {errors: ['Recipe is not valid']}, status: :unprocessable_entity
            end

        else
            render json: {errors: ['Log in to create a recipe']}, status: :unauthorized
        end
    end

end
