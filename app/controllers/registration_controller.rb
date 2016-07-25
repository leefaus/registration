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
      client = connect
      client.add_team_membership(self.get_team_id(client, partner.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')), account.login)
      client.add_team_membership(self.get_team_id(client, 'enablement-beta'), account.login)
      flash[:notice] = "Successfully registered for partner enablement"
      redirect_to action: 'show'
    rescue ActiveRecord::RecordNotUnique => e
      logger.info(e)
      flash[:alert] = "You have already registered!"
    end
  end

  def show

  end

  def get_team_id(client, team_name)
    teams = client.organization_teams('githubpartners', {:per_page => 500})
    channel_team_id = nil
    teams.each do |t|
      if t.name.eql? team_name
        channel_team_id = t.id
      end
    end
    channel_team_id
  end

end
