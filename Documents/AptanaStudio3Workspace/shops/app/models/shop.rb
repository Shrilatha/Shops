class Shop < ActiveRecord::Base
  
  # => Associations
  has_many        :shop_images
  
  # => Collect records based on Delete Flag
  scope :default, lambda{|flag| where("is_deleted = ?", flag)}
  
  #*************************************************************************************************************#
  # => Update Shop Master Records                                                                               #
  #                                                                                                             #
  # =>  Input  :                                                                                                #
  #        id           => "Id"                                                                                 #
  #        name         => "Shop Name"                                                                          #
  #        desc         => "Description"                                                                        #
  #        address      => "Address"                                                                            #
  #        lat          => "Latitude"                                                                           #
  #        long         => "Longitude"                                                                          #
  #                                                                                                             #
  # =>  Return :                                                                                                #
  #        Status Messages                                                                                      # 
  #*************************************************************************************************************#
  def self.update_shop_detail(id, name, desc, address, lat, long)  
    
    # => Create Shop
    if id.to_i == 0  
      
      # => Check for existence before creation (Marked Deleted)
      shop = self.find_by_name_and_latitude_and_longitude_and_is_deleted(name, lat, long, true)
      
      if !shop.nil?
        
        # => Update Details
        shop.update_attributes(
                                  :is_deleted => false
                              )
        
        return "The requested shop has been created successfully.$#{shop.id}"
                 
      # => Check for existence before creation (Not Deleted)
      elsif self.find_by_name_and_latitude_and_longitude_and_is_deleted(name, lat, long, false).nil?
        
        # => Create Details
        @data = self.create(
                              :name           => name,
                              :description    => desc,
                              :address        => address,
                              :latitude       => lat,
                              :longitude      => long,
                              :is_deleted     => false
                           ) 
                           
        return "The requested shop has been created successfully.$#{@data.id}"
        
      else
        
        return "Sorry!! The requested shop already exists."
        
      end
      
    else
      
      # => Check for Record Existence
      if !self.find_by_id(id).nil?
        
          # => Update Details
          self.find_by_id(id).update_attributes(
                                                  :name           => name,
                                                  :description    => desc,
                                                  :address        => address,
                                                  :latitude       => lat,
                                                  :longitude      => long,
                                                  :is_deleted     => false
                                               )
                                               
          return "The requested shop has been updated successfully."
          
      else
        
        return "Sorry!! The requested shop is not available for processing."
        
      end
      
    end
       
  end
  
end