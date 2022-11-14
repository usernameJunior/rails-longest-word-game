require "json"
require "open-uri"
class GamesController < ApplicationController
  def index() end

  def new
    # display a new random grid and a form
    @letters = 10.times.map { Array('a'..'z').sample }
  end

  def score
    @result = if params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].split.count(letter) }
                word_exist? ? 'Right' : 'Not a valid english word'
              else
                'Not in the grid'
              end
  end

  private

  def word_exist?
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    word = JSON.parse(word_serialized)
    word['found']
  end
end
