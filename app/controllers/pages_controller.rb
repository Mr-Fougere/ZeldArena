# frozen_string_literal: true
class PagesController < ApplicationController
  include TutorialData

  def home
    session[:tutorial_page] = 0 unless session[:tutorial_page]
    @tutorial_data = retrieve_data(session[:tutorial_page]) 
  end

  def next_tutorial_page
    session[:tutorial_page] += 1
    render turbo_stream: render_tutorial_modal
  end

  private

  def render_tutorial_modal
    turbo_stream.replace('tutorial-modal', partial: 'tutorials/modal',
                                          locals: { data: retrieve_data(session[:tutorial_page]) })
  end
end
