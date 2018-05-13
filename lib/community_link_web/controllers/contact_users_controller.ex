defmodule CommunityLinkWeb.ContactUsersController do
  use CommunityLinkWeb, :controller

  alias CommunityLink.Account.User
  alias CommunityLink.Cause


  def index(conn, %{"org_id" => org_id}) do
    organization = Cause.get_organization!(org_id)
    volunteers = Cause.volunteers_for_organization(org_id)
    render(conn, "index.html", organization: organization, volunteers: volunteers)
  end

end
