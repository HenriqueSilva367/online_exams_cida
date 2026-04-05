class Admin::AnswersController < Admin::BaseController
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy]

  # POST /admin/questions/:question_id/answers
  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to admin_question_path(@question), notice: 'Alternativa adicionada com sucesso!'
    else
      redirect_to admin_question_path(@question), alert: "Falha ao salvar alternativa: #{@answer.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    @question = @answer.question
    if @answer.destroy
      redirect_to admin_question_path(@question), notice: 'Alternativa removida.'
    else
      redirect_to admin_question_path(@question), alert: @answer.errors.full_messages.to_sentence
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:title, :is_correct)
  end
end
