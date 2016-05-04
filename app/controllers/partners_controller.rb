class PartnersController < ApplicationController
  before_action :authenticate_account!
  before_action :validate_permissions!

  def index
    @account = current_account
    @partners = Partner.all
  end

  def new
  end

  def create
    partner = Partner.create(
      :name => params[:partnerName],
      :country => params[:country],
      :city => params[:city]
    )
    client = connect
    repository = client.create_repository(
      partner.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, ''),
      {
        :description => "Repository for #{partner.name}",
        :private => "true",
        :has_issues => "true",
        :has_wiki => "true",
        :has_downloads => "true",
        :organization => "githubpartners",
        :auto_init => "true"
      })
    team = client.create_team('githubpartners', {
        :name => partner.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, ''),
        :repo_names => ["githubpartners/#{repository.name}"],
      })
    redirect_to({action: 'index'}, notice: "Successfully created #{partner.name}")
  end

end
