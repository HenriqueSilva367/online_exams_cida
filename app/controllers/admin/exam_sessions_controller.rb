class Admin::ExamSessionsController < Admin::BaseController
  before_action :set_exam_session, only: [:show]

  # GET /admin/exam_sessions
  def index
    # We want to list all Students who have taken exams
    @users_with_exams = User.joins(:exam_sessions).distinct.order(:full_name)
  end

  # GET /admin/exam_sessions/:id
  def show
    @user = @exam_session.user
    # All sessions for the left sidebar
    @all_sessions_for_user = @user.exam_sessions.order(created_at: :desc)
    
    # Get questions that were actually in this session
    @questions = Question.where(id: @exam_session.session_answers.pluck(:question_id)).includes(:answers)
    @answered_questions = @exam_session.session_answers.where.not(answer_id: nil).count
    @total_questions = @questions.count
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
    @exam_session = ExamSession.find(params[:id])
  end
end
