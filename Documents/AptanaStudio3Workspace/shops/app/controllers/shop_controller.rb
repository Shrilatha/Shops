class ShopController < ApplicationController
  
  def index
    
    # => Fetch List of Existing Shops
    @shops = Shop.default(
                            false   # => Is Deleted Flag - Unmarked
                         )
    
  end
  
  def new
    
  end
  
  def create
    
    # => Initializations
    @status = ""
    
    begin
      
      ActiveRecord::Base.transaction do
        
        # => Initializations
        shop = params[:shop]
        
        # => Create Shop Details
        @status = Shop.update_shop_detail(
                                              0,                # => Shop Id - New
                                              shop[:name],      # => Shop Name
                                              shop[:desc],      # => Shop Description
                                              shop[:address],   # => Address
                                              shop[:latitude],  # => Latitude
                                              shop[:longitude]  # => Longitude
                                         )
        
        # => Shop Id
        if !@status.include?("Sorry!!") && !shop["image"].nil?
          
          shop_id = @status.split("$")[1]
          
          # => Upload Shop Images
          ShopImage.update_shop_images(
                                          shop_id,        # => Shop ID
                                          shop["image"]   # => Image Array
                                      )
          
        end
        
      end
      
    rescue Exception => e
      
      @status = "Sorry!! Something went wrong.<br/>We've been notified about this issue and we'll take a look at it shortly."
       
    end
    
  end
  
  def show
    
    # => Shop ID
    shop_id = params[:id]
    
    # => Fetch Shop Record based on Shop ID
    @shop = Shop.where("id = ?", shop_id).includes(
                                                    :shop_images
                                                  ).first
    
  end
  
end
