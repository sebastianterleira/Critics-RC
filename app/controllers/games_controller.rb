class GamesController < ApplicationController
  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/:id
  def show
    @game = Game.find(params[:id])
  end

  # GET /games/new
  def new
    @game = Game.new
    @main_games = Game.main_game
  end

  # GET /games/:id/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/:id
  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/:id
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, status: :see_other
  end

  # Custom Routes

  # POST /games/:id/add_genre
  def add_genre
    game = Game.find(params[:id])
    genre = Genre.find(params[:genre_id])

    game.genres << genre
    redirect_to game
  end

  # DELETE /games/:id/remove_genre
  def remove_genre
    game = Game.find(params[:id])
    genre = Genre.find(params[:genre_id])

    game.genres.delete(genre)
    redirect_to game, status: :see_other
  end

  # POST /games/:id/add_platform
  def add_platform
    game = Game.find(params[:id])
    platform = Platform.find(params[:platform_id])

    game.platforms << platform
    redirect_to game
  end

  # POST /games/:id/add_developer
  def add_developer
    game = Game.find(params[:id])
    developer = InvolvedCompany.find(params[:company_id])
    
    game.developer << developer
    redirect_to game
  end
  
  # DELETE /games/:id/remove_developer
  def remove_developer
   game = Game.find(params[:id])
   developer = InvolvedCompany.find(params[:company_id])
 
   game.developer.delete(developer)
   redirect_to game, status: :see_other
 end

  private

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id, :cover)
  end
end
