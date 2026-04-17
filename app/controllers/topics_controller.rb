class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Simulados ANAC: Liberados individualmente + Liberados para a Turma
    individual_releases = current_user.released_simulations
    turma_releases = current_user.turma&.released_simulations || []
    @full_simulations = (individual_releases.to_a + turma_releases.to_a).uniq.sort_by(&:created_at).reverse
    
    # Exercícios: Buscamos os IDs das matérias autorizadas
    authorized_topic_ids = current_user.exercise_authorizations.pluck(:topic_id)
    
    # Lista de tópicos autorizados (usamos para montar os cards, mesmo que não tenham exames ainda)
    @authorized_topics = Topic.where(id: authorized_topic_ids).includes(:exams)
    
    # Mapeamento de exercícios por tópico para facilitar a exibição
    @exercises_by_topic = Exam.normal.where(topic_id: authorized_topic_ids).group_by(&:topic_id)
  end

  def show
    @topic = Topic.find(params[:id])
    @exams = @topic.exams
  end
end
