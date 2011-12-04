class GroupingsController < ApplicationController
  respond_to :html, :json
  def new
    @grouping = Grouping.new
    @grouping.event_url = 'http://atnd.org/events/22688'
  end
  
  def preview
    @grouping = Grouping.new(params[:grouping])
    if @grouping.valid?
      @grouping.pull_atnd_event
      @grouping.shuffle
      @json = @grouping.to_json({
        :except => [:_id],
        :include => {
          :groups => { 
            :except => [:_id], 
            :include => {
              :users => {
                :except => [:_id]
              },
            },
          },
          :users => { :except => [:_id]},
        }
      })
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
    @grouping = Grouping.new params[:grouping]
    p @grouping.groups
    if @grouping.save
      render :json => @grouping
    end
  end
  
  def show
  end

end
