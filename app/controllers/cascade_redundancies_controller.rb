class CascadeRedundanciesController < ApplicationController
  before_action :find_cascade_redundancy, only: %w(destroy)
  before_action :find_cascade, only: %w(create)

  def create
    @cascade_redundancy = @cascade.redundancies.new(cascade_redundancy_params)
    if @cascade_redundancy.save
      redirect_to @cascade, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def destroy
    @cascade_redundancy.destroy
    redirect_to @cascade_redundancy.cascade, notice: notice_sentence
  end

  protected
    def cascade_redundancy_params
      params.require(:cascade_redundancy).permit!
    end

    def find_cascade_redundancy
      @cascade_redundancy = CascadeRedundancy.find(params[:id])
    end

    def find_cascade
      @cascade = Cascade.find(params[:cascade_id])
    end
end
