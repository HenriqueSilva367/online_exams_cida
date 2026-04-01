class Admin::QuestionsController < Admin::BaseController
  before_action :set_exam, only: [:new, :create]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /admin/questions/:id
  def show
    @answers = @question.answers.order(created_at: :asc)
    @new_answer = @question.answers.build
  end

  # GET /admin/exams/:exam_id/questions/new
  def new
    @question = @exam.questions.build
  end

  # POST /admin/exams/:exam_id/questions
  def create
    @question = @exam.questions.build(question_params)
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

  # DELETE /admin/questions/:id
  def destroy
    @exam = @question.exam
    @question.destroy
    redirect_to admin_exam_path(@exam), notice: 'Questão e todas opções foram removidas.'
  end

  private

  def set_exam
    @exam = Exam.find(params[:exam_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title)
  end
end
