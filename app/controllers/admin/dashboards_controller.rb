class Admin::DashboardsController < Admin::BaseController
  def show
    @questions_count = Question.count
    @students_count = User.student.count
    @exercises_count = ExamSession.where.not(selected_topic_id: nil).count
    @recent_anac_exams = Exam.anac_pp.order(created_at: :desc).limit(5)
  end
end
