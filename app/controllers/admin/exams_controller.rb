class Admin::ExamsController < Admin::BaseController
  before_action :set_topic, only: [:new, :create]
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /admin/topics/:topic_id/exams/new
  def new
    @exam = @topic.exams.build
  end

  # GET /admin/exams/:id/edit
  def edit
  end

  # GET /admin/exams/:id
  def show
    # AQUI será a central onde o admin vê e adiciona Questões (Questions)
    @questions = @exam.questions.includes(:answers)
  end

  # POST /admin/topics/:topic_id/exams
  def create
    @exam = @topic.exams.build(exam_params)

    if @exam.save
      redirect_to admin_topic_path(@topic), notice: 'Prova criada com sucesso! Agora você pode adicionar perguntas.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/exams/:id
  def update
    if @exam.update(exam_params)
      redirect_to admin_topic_path(@exam.topic), notice: 'Prova atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/exams/:id
  def destroy
    @topic = @exam.topic
    @exam.destroy
    redirect_to admin_topic_path(@topic), notice: 'Prova foi excluída silenciosamente.'
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:title, :description, :difficulty, :time_duration)
  end
end
