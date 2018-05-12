defmodule CommunityLink.Factory do
  use ExMachina.Ecto, repo: CommunityLink.Repo

  def user_factory do
    %CommunityLink.Account.User{
      name: sequence(:name, &"user-#{&1}"),
    }
  end

  def organization_factory do
    %CommunityLink.Cause.Organization{
      name: sequence(:name, &"org-#{&1}"),
      description: sequence(:description, &"desc-#{&1}"),
      owner: build(:user)
    }
  end
end
