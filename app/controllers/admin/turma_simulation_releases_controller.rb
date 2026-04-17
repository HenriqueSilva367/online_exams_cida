class Admin::TurmaSimulationReleasesController < Admin::BaseController
  def create
    @turma = Turma.find(params[:turma_id])
    @exam = Exam.find(params[:exam_id])

    @turma.turma_simulation_releases.find_or_create_by!(exam: @exam)
    redirect_back fallback_location: admin_turma_path(@turma),
                  notice: "Simulado \"#{@exam.title}\" liberado para a turma #{@turma.name}."
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: admin_turma_path(@turma), alert: "Erro: #{e.message}"
  end

  def destroy
    @release = TurmaSimulationRelease.find(params[:id])
    @turma = @release.turma
    exam_title = @release.exam.title
    @release.destroy!
    redirect_back fallback_location: admin_turma_path(@turma),
                  notice: "Simulado \"#{exam_title}\" revogado da turma #{@turma.name}."
  end
end
