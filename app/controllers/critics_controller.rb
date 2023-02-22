class CriticsController < ApplicationController
  # GET /critics
  def index
    @critics = Critic.all
  end

  # GET /critics/:id
  def show
    @critic = Critic.find(params[:id])
  end

  # GET /critics/new || /critics/new?game_id=:id || /critics/new?company_id=:id
  # GET /games/:game_id/critics/new
  # GET /company/:company_id/critics/new
  def new
    criticable = Game.find(params[:game_id]) if params[:game_id]
    criticable = Company.find(params[:company_id]) if params[:company_id]

    if criticable # <Game /> || <Compny />
      @critic = criticable.critics.new # <#Critics />
      # render "new"
    else
      render "criticable"
    end
  end

  # GET /critics/:id/edit
  def edit
    @critic = Critic.find(params[:id])
  end

  # POST /critics
  # POST /games/:game_id/critics
  # POST /company/:company_id/critics
  def create
    if params[:game_id]
      criticable = Game.find(params[:game_id])
    elsif params[:company_id]
      criticable = Company.find(params[:company_id])
    end

    @critic = Critic.new(critic_params)
    @critic.criticable = criticable
    @critic.user = current_user

    if @critic.save
      redirect_to @critic.criticable, notice: "Critic was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /critics/:id
  def update
    @critic = Critic.find(params[:id])

    if @critic.update(critic_params)
      redirect_to @critic
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /critics/:id
  def destroy
    @critic = Critic.find(params[:id])
    @critic.destroy
    redirect_to critics_path, status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def critic_params
    params.require(:critic).permit(:title, :body, :user_id)
  end
end
