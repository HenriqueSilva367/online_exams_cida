# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

admin = User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.name = 'Admin User'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = :admin
end

student = User.find_or_create_by!(email: 'student@example.com') do |u|
  u.name = 'Student User'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = :student
end

ruby_topic = Topic.find_or_create_by!(title: 'Ruby on Rails') do |t|
  t.description = 'General knowledge about Ruby on Rails framework'
end

exam = Exam.find_or_create_by!(title: 'Rails Basics', topic: ruby_topic) do |e|
  e.description = 'Test your basic knowledge of Ruby on Rails'
  e.difficulty = 'Easy'
  e.time_duration = 5
end

Question.find_or_create_by!(title: 'What does MVC stand for in Rails?', exam: exam) do |q|
  correct = q.answers.build(title: 'Model View Controller', is_correct: true)
  q.answers.build(title: 'Multi View Container', is_correct: false)
  q.answers.build(title: 'Model View Component', is_correct: false)
end

Question.find_or_create_by!(title: 'What command generates a new Rails app?', exam: exam) do |q|
  correct = q.answers.build(title: 'rails new app_name', is_correct: true)
  q.answers.build(title: 'rails init app_name', is_correct: false)
  q.answers.build(title: 'rails make app_name', is_correct: false)
end
