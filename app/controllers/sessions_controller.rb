class SessionsController < ApplicationController

  def new
    # renderöi kirjautumissivun
  end

  def create
    # haetaan käyttäjä tietokannasta usernamella
    user = User.find_by username: params[:username]

    if user.nil?
      redirect_to :back, notice: "User #{params[:username]} does not exist!"
      elsif user && user.authenticate(params[:password])
        if user.active == false
          redirect_to :back, notice: "This account is frozen. Please contact an administrator for further information."
          return
        end
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
      redirect_to :back, notice: "Username and/or password mismatch"
    end

  end

  def destroy
    # session nollaus
    session[:user_id] = nil
    redirect_to :root
  end

end
