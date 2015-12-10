
require 'open-uri'
class SellersController < ApplicationController

  def index

    # query = params.fetch(:query, 'wood')

    shop = params.fetch(:shop, 'allencompany')

    limit = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/listings/active?api_key=#{api_key}&#{limit}&includes=MainImage"
    response = JSON.parse(open(url).read)
    @items = response['results']
  

    url = "https://openapi.etsy.com/v2/shops/#{shop}/sections?api_key=#{api_key}&#{limit}&includes=MainImage"
    response3 = JSON.parse(open(url).read)
    @sections = response3['results']

    # defined listing_id (format) in the link_to

    url = "https://openapi.etsy.com/v2/shops/#{shop}/listings/active?api_key=#{api_key}#{limit}&includes=MainImage"
    response = JSON.parse(open(url).read)
    @page = response['pagination']


    # limit = params[:format]

  end


  def listing

    id = params[:format]

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/listings/#{id}?api_key=#{api_key}"
    # byebug
    response = JSON.parse(open(url).read)
    @items = response['results']

    url = "https://openapi.etsy.com/v2/listings/#{id}/images?api_key=#{api_key}"
    response2 = JSON.parse(open(url).read)
    @images = response2['results']

  end


  def section

    shop = params.fetch(:shop, 'allencompany')

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


  end

  def home 


  shop = params.fetch(:shop, 'allencompany')

  api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']
  
  end



  def about

    # (policies)

    shop = params.fetch(:shop, 'allencompany')

    api_key = ENV['ETSY_API_KEY']

    url = "https://openapi.etsy.com/v2/shops/#{shop}?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @infos = response4['results']

    url = "https://openapi.etsy.com/v2/shops/#{shop}/about?api_key=#{api_key}"
    response4 = JSON.parse(open(url).read)
    @about = response4['results']

  end


end