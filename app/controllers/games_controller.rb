require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a[rand(26)]
    end
  end

  def score
    @attempt = params[:word].upcase.chars
    @letters = params[:letters]
    if @attempt.all? { |letter| @attempt.count(letter) <= @letters.count(letter) }
      word = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
      word["found"] ? @message = "Well done!" : @message = "Word not found"
    else @message = "Not in the grid"
    end
  end
end
