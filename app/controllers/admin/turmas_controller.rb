class Admin::TurmasController < Admin::BaseController
  before_action :set_turma, only: [:show, :edit, :update, :destroy]

  def index
    @turmas = Turma.order(created_at: :desc)
  end

  def show
    @users = @turma.users.order(:full_name)
    @anac_exams = Exam.anac_pp.order(created_at: :desc)
    @released_exam_ids = @turma.turma_simulation_releases.pluck(:exam_id).to_set
  end

  def new
    @turma = Turma.new
  end

  def edit
  end

  def create
    @turma = Turma.new(turma_params)

    if @turma.save
      redirect_to admin_turmas_path, notice: 'Turma criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @turma.update(turma_params)
      redirect_to admin_turmas_path, notice: 'Turma atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @turma.destroy
    redirect_to admin_turmas_path, notice: 'Turma excluída com sucesso.'
  end

  private

  def set_turma
    @turma = Turma.find(params[:id])
  end

  def turma_params
    params.require(:turma).permit(:name, :description)
  end
end
