defmodule CommunityLinkWeb.OrganizationController do
  use CommunityLinkWeb, :controller

  alias CommunityLink.Cause
  alias CommunityLink.Cause.Organization

  def index(conn, _params) do
    organizations = Cause.list_organizations()
    render(conn, "index.html", organizations: organizations)
  end

  def new(conn, _params) do
    users = CommunityLink.Account.list_users()
    changeset = Cause.change_organization(%Organization{})
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"organization" => organization_params}) do
    case Cause.create_organization(organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: organization_path(conn, :show, organization))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Cause.get_organization!(id)
    render(conn, "show.html", organization: organization)
  end

  def edit(conn, %{"id" => id}) do
    users = CommunityLink.Account.list_users()
    changeset = Cause.change_organization(%Organization{})
    organization = Cause.get_organization!(id)
    changeset = Cause.change_organization(organization)
    render(conn, "edit.html", organization: organization, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Cause.get_organization!(id)

    case Cause.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: organization_path(conn, :show, organization))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Cause.get_organization!(id)
    {:ok, _organization} = Cause.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: organization_path(conn, :index))
  end
end
