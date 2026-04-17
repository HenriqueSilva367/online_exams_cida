class Admin::GeneratorsController < Admin::BaseController
  # POST /admin/generators/generate_full_exam
  def generate_full_exam
    # Sorteamos 20 questões de cada tópico que tenha questões
    questions_to_add = []
    topics_with_questions = Topic.joins(:questions).distinct

    topics_with_questions.each do |topic|
      questions_to_add += topic.questions.order("RANDOM()").limit(20).to_a
    end

    if questions_to_add.empty?
      return redirect_to admin_dashboard_path, alert: "Não há questões suficientes cadastradas nos tópicos."
    end

    # Criamos o Exame
    exam_title = "Simulado Completo ANAC ##{Time.current.strftime('%d%m%y-%H%M')}"
    @exam = Exam.create!(
      title: exam_title,
      description: "Simulado gerado automaticamente em #{Time.current.strftime('%d/%m/%Y %H:%M')}",
      exam_type: :anac_pp,
      time_duration: 180 # Padrão ANAC 3h
    )

    # Associamos as questões
    @exam.questions << questions_to_add

    redirect_to admin_exam_path(@exam), notice: "Simulado Completo gerado com sucesso com #{questions_to_add.size} questões!"
  end

  # POST /admin/generators/generate_exercise
  def generate_exercise
    topic = Topic.find(params[:topic_id])
    questions_to_add = topic.questions.order("RANDOM()").limit(20).to_a

    if questions_to_add.empty?
      return redirect_to admin_topic_path(topic), alert: "Não há questões cadastradas para este tópico."
    end

    exam_title = "Exercício: #{topic.title} ##{Time.current.strftime('%d%m%y')}"
    @exam = Exam.create!(
      title: exam_title,
      description: "Exercício individual gerado automaticamente em #{Time.current.strftime('%d/%m/%Y %H:%M')}",
      topic_id: topic.id,
      exam_type: :normal,
      time_duration: nil
    )

    @exam.questions << questions_to_add

    redirect_to admin_exam_path(@exam), notice: "Exercício de #{topic.title} gerado com sucesso!"
  end
end
