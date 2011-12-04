class GroupingsController < ApplicationController
  respond_to :html, :json
  def new
    @grouping = Grouping.new
    @grouping.event_url = 'http://atnd.org/events/22297'
  end
  
  def preview
    @grouping = Grouping.new(params[:grouping])
    if @grouping.valid?
      @grouping.pull_atnd_event
      @grouping.shuffle
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => 'groupings', :layout => false
          end
        end
      end
    end
  end
  
  def create
    @grouping = Grouping.new
    if @grouping.valid?
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => 'groupings', :layout => false
          end
        end
      end
    end
  end
  
  def show
  end

end
