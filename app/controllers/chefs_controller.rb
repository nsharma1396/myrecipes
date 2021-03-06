class ChefsController < ApplicationController
	before_action :set_chef, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]

	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 1)
	end

	def new
		@chef = Chef.new
	end

	def create
		@chef = Chef.new(chef_params)
		if @chef.save
			flash[:success] = "Your account has been created successfully"
			session[:chef_id] = @chef.id
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	def show
		@recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
	end

	def edit
	end

	def update
		if @chef.update(chef_params)
			flash[:success] = "Your profile was updated successfully"
			redirect_to chef_path(@chef)
		else
			render 'edit'
		end
	end

	def search
		@chef = Chef.new
	end

	def find
		@chefname = params[:chefname]
		search_results = Chef.where( chefname: params[:chefname] )
		if @chefname==""
			flash[:danger] = "Enter a name to search!"
			redirect_back fallback_location: search_path
		elsif search_results==[]
			flash[:danger] = "No Chefs with the name "+@chefname
			redirect_back fallback_location: search_path
		else
			@chefs = search_results.paginate(page: params[:page], per_page: 1)
		end
	end

	private

		def chef_params
			params.require(:chef).permit(:chefname, :email, :password)
		end

		def set_chef
			@chef = Chef.find(params[:id])
		end

		def require_same_user
			if current_user != @chef
				flash[:danger] = "You can only edit your own profile"
				redirect_to root_path
			end
		end
end