# -*- encoding : utf-8 -*-
class NavigationsController < ApplicationController
  before_action :find_namespace, only: %w(new create)
  before_action :find_navigation, only: %w(show edit update destroy)
  
  def show
  end
  
  def new
    @navigation = Navigation.new
  end
  
  def edit
  end
  
  def create
    @navigation = @namespace.navigations.new(navigation_params)
    if @navigation.save
      redirect_to @namespace, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @navigation.update(navigation_params)
      redirect_to @navigation.namespace, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @navigation.destroy!
    redirect_to @navigation.namespace, notice: notice_sentence
  end

  protected
    def navigation_params
      params.require(:navigation).permit!
    end

    def find_namespace
      @namespace = Namespace.find(params[:namespace_id])
    end

    def find_navigation
      @navigation = Navigation.find(params[:id])
    end
end
