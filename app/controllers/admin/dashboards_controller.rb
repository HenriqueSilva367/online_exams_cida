class Admin::DashboardsController < Admin::BaseController
  def show
    @questions_count = Question.count
    @students_count = User.student.count
    @exercises_count = ExamSession.where.not(selected_topic_id: nil).count
  end
end
