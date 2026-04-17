class ExamSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exam_session, only: [:show, :update, :cancel, :finish, :results]
  before_action :check_session_editable, only: [:show, :update]

  def index
    @exam_sessions = current_user.exam_sessions.order(created_at: :desc)
  end

  def show
    # Renders the exam taking view
    @exam = @exam_session.exam
    @session_answers = @exam_session.session_answers.index_by(&:question_id)
    
    # Pre-filled questions are the only source now for dynamic exams
    @questions = Question.where(id: @session_answers.keys).includes(:answers)
  end

  def create
    @exam = Exam.find(params[:exam_id])
    topic_id = params[:selected_topic_id]

    if topic_id.present?
      # É um Exercício de Matéria Única
      unless current_user.admin? || current_user.exercise_authorizations.exists?(topic_id: topic_id)
        return redirect_to topics_path, alert: 'Você ainda não tem autorização para realizar este exercício. Fale com seu Professor.'
      end
    else
      # É um Simulado Completo ANAC
      individual_access = current_user.released_simulations.exists?(id: @exam.id)
      turma_access = current_user.turma&.released_simulations&.exists?(id: @exam.id)

      unless current_user.admin? || individual_access || turma_access
        return redirect_to topics_path, alert: 'Você não possui liberação para realizar este Simulado ANAC. Fale com seu Professor.'
      end

      if current_user.student? && current_user.credits <= 0
        return redirect_to topics_path, alert: 'Você não possui mais créditos de Simulados. Entre em contato com a administração.'
      end
      
      # Desconta crédito para alunos em simulado completo
      current_user.decrement!(:credits) if current_user.student?
    end

    @exam_session = current_user.exam_sessions.create!(
      exam: @exam,
      selected_topic_id: topic_id,
      status: :in_progress,
      started_at: Time.current
    )

    # Pre-fill questions purely from the existing Exam
    @exam.questions.each do |q|
      @exam_session.session_answers.create!(question: q)
    end

    redirect_to @exam_session
  end

  def update
    # Save a student's answer as they click it or submit it
    # Use fetch to avoid error if exam_session key is missing (e.g. no answers selected)
    exam_session_params = params.fetch(:exam_session, {})
    responses = exam_session_params.permit(responses: {})[:responses] || {}
    
    responses.each do |question_id, answer_id|
      session_answer = @exam_session.session_answers.find_or_initialize_by(question_id: question_id)
      session_answer.answer_id = answer_id
      session_answer.save!
    end

    if params[:commit] == 'Submit Exam' || params[:status] == 'completed'
      finish_session(:completed)
      redirect_to results_exam_session_path(@exam_session)
    else
      # Just saved progress
      head :ok
    end
  end

  def cancel
    @exam_session.update!(status: :canceled)
    redirect_to exam_sessions_path, notice: 'Exam session canceled.'
  end

  def finish
    # Typically called via JS when timer hits 0
    finish_session(:uncompleted)
    redirect_to results_exam_session_path(@exam_session)
  end

  def results
    # Show stats
    @exam = @exam_session.exam
    @total_questions = @exam_session.session_answers.count
    @questions = Question.where(id: @exam_session.session_answers.pluck(:question_id)).includes(:answers)
    @answered_questions = @exam_session.session_answers.where.not(answer_id: nil).count
    @correct_answers = 0
    
    @exam_session.session_answers.each do |sa|
      if sa.answer&.is_correct
        @correct_answers += 1
      end
    end
    
    @incorrect_answers = @total_questions - @correct_answers
    @accuracy = @total_questions > 0 ? (@correct_answers.to_f / @total_questions * 100).round(2) : 0
  end

  private

  def set_exam_session
    @exam_session = current_user.exam_sessions.find(params[:id])
  end

  def check_session_editable
    unless @exam_session.in_progress?
      redirect_to results_exam_session_path(@exam_session), alert: 'This exam session is already finished.'
    end
    
    duration = @exam_session.effective_duration
    if duration && @exam_session.started_at + duration.minutes < Time.current
      finish_session(:uncompleted)
      redirect_to results_exam_session_path(@exam_session), alert: 'Time is up! Exam uncompleted.'
    end
  end

  def finish_session(status)
    @exam_session.update!(
      status: status,
      finished_at: Time.current
    )
    # calculate score
    correct = 0
    @exam_session.session_answers.each do |sa|
      correct += 1 if sa.answer&.is_correct
    end
    @exam_session.update!(score: correct)
    @exam_session.calculate_anac_result! if @exam_session.exam.anac_pp?
  end
end
