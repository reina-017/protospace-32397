class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @prototypes = Prototype.all
  end

  def new
    unless user_signed_in?
      redirect_to root_path
    end
    @prototype = Prototype.new
  end

  def create 
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
       redirect_to root_path     
    else
      render :new      
    end
  end

  def show 
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    render "prototypes/show"
  end

  def edit 
    unless user_signed_in?
      redirect_to root_path
    end
    @prototype = Prototype.find(params[:id])
    
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path     
   else
     render :edit      
   end
  end

   def destroy
    unless user_signed_in?
      redirect_to root_path
    end
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
   end
  



  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
