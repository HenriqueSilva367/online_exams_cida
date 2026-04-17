class Admin::QuestionsController < Admin::BaseController
  before_action :set_parent, only: [:new, :create]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /admin/questions/:id
  def show
    @answers = @question.answers.order(created_at: :asc)
    @new_answer = @question.answers.build
  end

  # GET /admin/exams/:exam_id/questions/new
  # GET /admin/topics/:topic_id/questions/new
  def new
    @question = @parent.questions.build
    @question.topic_id = @parent.id if @parent.is_a?(Topic)
  end

  # POST /admin/exams/:exam_id/questions
  # POST /admin/topics/:topic_id/questions
  def create
    @question = @parent.questions.build(question_params)
    @question.topic_id = @parent.id if @parent.is_a?(Topic)
    
    if @question.save
      redirect_to admin_question_path(@question), notice: 'Enunciado criado perfeitamente! Agora crie as opções A, B, C... para ele.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/questions/:id/edit
  def edit
  end

  # PATCH/PUT /admin/questions/:id
  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: 'Enunciado atualizado.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    parent = @question.topic || @question.exam
    if @question.destroy
      redirect_to (parent.is_a?(Topic) ? admin_topic_path(parent) : admin_exam_path(parent)), notice: 'Questão e todas opções foram removidas.'
    else
      redirect_to admin_question_path(@question), alert: @question.errors.full_messages.to_sentence
    end
  end

  private

  def set_parent
    if params[:exam_id]
      @parent = Exam.find(params[:exam_id])
    elsif params[:topic_id]
      @parent = Topic.find(params[:topic_id])
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:exam_id, :title, :topic_id, :explanation, :explanation_image, explanation_images: [])
  end
end
