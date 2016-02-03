class SessionsController < ApplicationController

  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan käyttäjä tietokannasta usernamella
    user = User.find_by username: params[:username]
    if user.nil?
        redirect_to :back, notice: "User #{params[:username]} does not exist!"
      else
        # talletetaan id sessioon
        session[:user_id] = user.id
        redirect_to user, notice: "Welcome back!"
      end
  end

  def destroy
    # session nollaus
    session[:user_id] = nil
    redirect_to :root
  end

end
