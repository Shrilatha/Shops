module TabsHelper
  #*************************************************************************************************************#
  # => Load Active Tab based on Selected Pages                                                                  #
  # => active_tab   -> Load Active for Current Tab                                                              #
  #                                                                                                             #
  #*************************************************************************************************************#
  def tabs(active_tab=1)

    # => Render Tabs Partial According to Selected Pages
    render :partial => 'partials/tabs',:locals=>{:current_tab=>active_tab}

  end

end