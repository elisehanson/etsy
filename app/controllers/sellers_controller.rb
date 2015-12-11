
require 'open-uri'
class SellersController < ApplicationController

  def index

    # MY SHOP 

    # query = params.fetch(:query, 'wood')
    
    puts current_user.email
    shop = current_user.email

    # shop = User.find_by_shop_name(params[:shop_name]).shop_name

    # puts params.inspect
    # puts shop.id.to_s + "  " + shop.email

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

  

    # limit = params[:format]

  end


  def listing

        puts current_user.email
    shop = current_user.email

    id = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/listings/#{id}?api_key=#{api_key}"
    # byebug
    response = JSON.parse(open(url).read)
    @items = response['results']

    url = "https://openapi.etsy.com/v2/listings/#{id}/images?api_key=#{api_key}"
    response2 = JSON.parse(open(url).read)
    @images = response2['results']

        url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']

  end


  def section

    puts current_user.email
    shop = current_user.email

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

  def home 

    puts current_user.email
    shop = current_user.email

  # shop = params.fetch(:shop, 'allencompany')

  api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']
  
  end



  def about

    # (policies)

    # shop = params.fetch(:shop, 'allencompany')

    puts current_user.email
    shop = current_user.email

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']

    # url = "https://openapi.etsy.com/v2/shops/#{shop}/about?api_key=#{api_key}"
    # response5 = JSON.parse(open(url).read)
    # @about = response5['results']

  end


end