class WelcomeController < ApplicationController
  def index
  end  
  def search	
  	# filter = {name:params[:name], price:{params[:price]}}
  	# filter.delete_if { |key, value| value.blank? }

	@listing = Listing.search params[:search]#, where:filter
	render "/listings/index.html.erb"
  end

  # private
  # def search_params
  # 	params.require(:details).permit(:name, :price, :) 	
  # end
end
