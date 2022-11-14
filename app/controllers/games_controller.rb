class GamesController < ApplicationController
  def index() end

  def new
    # display a new random grid and a form
    @letters = 10.times.map { Array('a'..'z').sample }
  end

  def score
    @result = checkword
  end

  private

  def checkword
    if word_exist? && word_in_grid?
      "Congratulations ! #{params[:word].upcase} is a valid english word!"
    elsif !word_exist?
      "Sorry but #{params[:word].upcase} does not seem to be a valid english word."
    else
      "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters].upcase.split.join(', ')}"
    end
  end

  def word_in_grid?
    params[:word].downcase.chars.all? do |letter|
      params[:word].count(letter) <= params[:letters].split.count(letter)
    end
  end

  def word_exist?
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    word = JSON.parse(word_serialized)
    word['found']
  end
end
