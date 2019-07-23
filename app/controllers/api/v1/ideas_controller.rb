class Api::V1::IdeasController < ApplicationController
  before_action :set_idea, only: [:update, :show, :destroy]

  def index
    @ideas = Idea.order(created_at: :desc)

    json_response(@ideas)
  end

  def create
    @idea = Idea.create! idea_params

    json_response @idea, :created
  end

  def show
    json_response @idea
  end

  def update
    @idea.update idea_params
    head :no_content
  end

  def destroy
    @idea.destroy

    head :no_content
  end 

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:title, :body)
    end
end
