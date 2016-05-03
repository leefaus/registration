class RegistrationController < ApplicationController
  before_action :authenticate_account!

  def new
    @account = current_account
    @partner = Partner.find_by id: params[:partner_id]
  end

  def create
    partner = Partner.find_by id: params[:partnerId]
    account = Account.find_by login: params[:githubAccount]
    registrant = params[:registrant]
    begin
      @registrant = Registrant.create(
        :first_name => params[:firstName],
        :last_name => params[:lastName],
        :email_address => params[:emailAddress],
        :primary => registrant[:primary],
        :git_comfort_level => params[:gitComfortLevel],
        :github_comfort_level => params[:githubComfortLevel],
        :custom_development_comfort_level => params[:developmentComfortLevel],
        :administration_comfort_level => params[:administrationComfortLevel],
        :goals => params[:goals],
        :partner => partner,
        :account => account
      )
      flash[:notice] = "Successfully registered for partner enablement"
    rescue ActiveRecord::RecordNotUnique => e
      logger.info(e)
      flash[:alert] = "You have already registered!"
    end

  end

end
