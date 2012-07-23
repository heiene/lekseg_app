class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])

	  	if @user.save
	  		flash[:success] = "Welcome to this test page"
	  		sign_in @user
	  		redirect_to @user
	  	else
	  		render 'new'

		end
	end
  
  def index
		@users = User.paginate(page: params[:page], per_page: 10)
	end

  def show
  	@user = User.find(params[:id])
  end

  def edit 	# trenger ikke no definert her iom at before_filter :correct_user kicker igang correct user metode
  end				# som igjen definerer @user bassert på id og sjekker om det er riktig user

  def update
  		if @user.update_attributes(params[:user])
  			flash[:success] = "Profile updated"
	      sign_in @user
	      redirect_to @user
  		else
  			render 'edit'
  		end
  end

  def destroy
    killuser = User.find(params[:id])
    name_to_kill= killuser.name
    killuser.destroy
    flash[:success] = "User: #{name_to_kill} is destroyed."
    redirect_to users_path
  end
  
  private

	  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in." 
      end
	  end
  
   	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end

