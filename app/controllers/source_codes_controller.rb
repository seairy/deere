# -*- encoding : utf-8 -*-
class SourceCodesController < ApplicationController
  before_action :find_source_code, only: %w(show)
  
  def index
    @source_codes = @current_project.source_codes
  end

  def show
  end

  def compile
    @current_project.compile
    redirect_to source_codes_path, notice: notice_sentence
  end

  protected
    def find_source_code
      @source_code = @current_project.source_codes.find(params[:id])
    end
end
