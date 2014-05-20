class PagesController < ApplicationController
  layout false, only: :video

  def index
  end

  def about
  end

  def faq
    @faq = YAML.load(File.read Rails.root.join('config', 'faq.yml'))
  end

  def terms
  end

  def privacy
  end

  def video
  end
end
