class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :connect

  def validate_permissions!
    @client = self.connect
    teams = @client.organization_teams('githubpartners'), :per_page => 200
    channel_team_id = nil
    teams.each do |t|
      if t.name.eql? "github-channels"
        channel_team_id = t.id
      end
    end
    if channel_team_id.nil?
      redirect_to "/", alert: "Couldn't find team named github-channels."
    elsif not @client.team_member?(channel_team_id, current_account.login)
      redirect_to "/", alert: "You don't have enough permissions to access this page."
    end
  end

  def connect
    Octokit.configure do |c|
      if ENV['enterprise'].eql? "true"
        c.api_endpoint = "http://#{ENV['github_enterprise_url']}/api/v3/"
        # allow self signed cert https
        c.connection_options[:ssl] = { :verify => false }
      end
    end
    client = Octokit::Client.new(
        :access_token => ENV['github_oauth_personal_token']
        )
  end

end
