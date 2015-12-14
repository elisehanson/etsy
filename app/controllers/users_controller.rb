class UsersController < ApplicationController

	def new
		render "users/new", :layout => false
	end


def create
	@user = User.new(user_params)
	if @user.save
		flash[:notice] = "Welcome to the site!"
		session[:user_id] =  @user.id
		redirect_to "/index"
	else
		flash[:alert] = "There was a problem creating your account. Please try again."
		redirect_to :back
	end
end


def index

  api_key = ENV['ETSY_API_KEY']

	@users = User.all

    allshops =  User.connection.select_values(User.select("email").to_sql)

    # parse?

    puts allshops

    shop = allshops.last

    puts shop

    # each shop do this =

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']


    puts url


end


def show 

    @user = User.find params[:id]

    puts @user.email

    shop = @user.email

    limit = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/listings/active?api_key=#{api_key}&#{limit}&includes=MainImage"
    # byebug
    puts url
    response = JSON.parse(open(url).read)
    @items = response['results']
  

    url = "https://openapi.etsy.com/v2/shops/#{shop}/sections?api_key=#{api_key}&#{limit}&includes=MainImage"
    response3 = JSON.parse(open(url).read)
    @sections = response3['results']

    # defined listing_id (format) in the link_to

    url = "https://openapi.etsy.com/v2/shops/#{shop}/listings/active?api_key=#{api_key}&#{limit}&includes=MainImage"
    response = JSON.parse(open(url).read)
    @page = response['pagination']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']

end


 def listing

	# @user = User.find params[:id]

 #    puts @user.email

    # shop = @user.email

    id = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/listings/#{id}?api_key=#{api_key}"
    # byebug
    response = JSON.parse(open(url).read)
    @items = response['results']

    url = "https://openapi.etsy.com/v2/listings/#{id}/images?api_key=#{api_key}"
    response2 = JSON.parse(open(url).read)
    @images = response2['results']

    #     url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    # response4 = JSON.parse(open(url).read)
    # @infos = response4['results']

 end



  def section

@user = User.find params[:user_id]

    puts @user.email

    shop = @user.email

    section_id = params[:format]

    limit = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/sections?api_key=#{api_key}&includes=MainImage"
    response3 = JSON.parse(open(url).read)
    @sections = response3['results']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/sections/#{section_id}/listings/active?api_key=#{api_key}&includes=MainImage"
    response = JSON.parse(open(url).read)
    @items = response['results']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/sections/#{section_id}/listings/active?api_key=#{api_key}&#{limit}&includes=MainImage"
    response = JSON.parse(open(url).read)
    @page = response['pagination']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']
  end


    def about

    # (policies)

    # shop = params.fetch(:shop, 'allencompany')

    @user = User.find params[:user_id]

    puts @user.email

    shop = @user.email

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']

    # url = "https://openapi.etsy.com/v2/shops/#{shop}/about?api_key=#{api_key}"
    # response5 = JSON.parse(open(url).read)
    # @about = response5['results']

  end




  def edit
    @user = User.find params[:id]
  end


  # update action
  def update
    @user = User.find params[:id]
        respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end



def destroy
  @user = User.find params[:id]
  @user.destroy
  redirect_to users_path
end



private

def user_params
	params.require(:user).permit(:email, :password, :password_confirmation, :image)
end

end
