class ExamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topic = Topic.find(params[:topic_id])
    @exams = @topic.exams
  end

  def show
    @topic = Topic.find(params[:topic_id])
    @exam = @topic.exams.find(params[:id])
  end
end
