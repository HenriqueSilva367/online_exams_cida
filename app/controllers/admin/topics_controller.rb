class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
    if params[:q_questions].present?
      @questions_found = Question.where("title ILIKE ?", "%#{params[:q_questions]}%")
                                .limit(50)
    end
  end

  def show
    @questions = @topic.questions.order(created_at: :desc)
    @exams = @topic.exams.normal.order(created_at: :desc)
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to admin_topic_path(@topic), notice: 'Topic was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to admin_topic_path(@topic), notice: 'Topic was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_topics_path, notice: 'Topic was successfully destroyed.'
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
