require 'open-uri'
# require 'json'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    @message = score_and_message(@answer, @letters)
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score_and_message(attempt, grid)
  if included?(attempt.upcase, grid)
    if english_word?(attempt)
      "well done"
    else
      "not an english word"
    end
    else
      "not in the grid"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

