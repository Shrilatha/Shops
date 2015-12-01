class ShopImage < ActiveRecord::Base
  
  # Associations
  belongs_to :shop,        :foreign_key => "shop_id"
  
  # Paperclip Interpolates for adding Shop Image Id in URL & Path
  Paperclip.interpolates :shop_id do |attachment, style|
    attachment.instance.shop_id
  end
  
  # Shop Image
  has_attached_file :image, 
                    :url => "/Repository/ShopImages/:shop_id/:basename.:extension",
                    :path => ":rails_root/public/Repository/ShopImages/:shop_id/:basename.:extension"
  
  # Validate Content types for Pics
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  #*************************************************************************************************************#
  # => Update Shop Images                                                                                       #
  #                                                                                                             #
  # =>  Input  :                                                                                                #
  #        id           => "Id"                                                                                 #
  #        shop_id      => "Shop Id"                                                                            #
  #        images       => "Images"                                                                             #
  #                                                                                                             #
  # =>  Return :                                                                                                #
  #        Status Messages                                                                                      # 
  #*************************************************************************************************************#
  def self.update_shop_images(shop_id, images)  
    
    # => Create Thread for Images
    thread_array = []
    file_names = []
    cnt_success = 0
    
    images.each do |content|

      thread_array << Thread.new {
        begin
          # => Create Details
          @data = self.create(
                                  :shop_id               => shop_id,                 # => Shop ID
                                  :image                 => content                  # => Image Content
                             )
        ensure
          ActiveRecord::Base.connection_pool.release_connection
        end
      }
      cnt_success = cnt_success + 1
    
    end   
    
    # => Execute Thread
    thread_array.each { |thr| thr.join }
                         
    return "The Images has been saved successfully.$#{cnt_success}"
      
  end  
  
end