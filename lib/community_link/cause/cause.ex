defmodule CommunityLink.Cause do
  @moduledoc """
  The Cause context.
  """

  import Ecto.Query, warn: false
  alias CommunityLink.Repo

  alias CommunityLink.Account.User
  alias CommunityLink.Cause.Organization
  alias CommunityLink.Cause.Event
  alias CommunityLink.Cause.UserEvent

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations do
    Repo.all(Organization)
  end

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id) do
    query = from org in Organization,
      left_join: events in assoc(org, :events),
      where: org.id == ^id,
      preload: [events: events]

    Repo.one!(query)
  end

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{source: %Organization{}}

  """
  def change_organization(%Organization{} = organization) do
    Organization.changeset(organization, %{})
  end

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  @doc """
  Returns the list of users_events.

  ## Examples

      iex> list_users_events()
      [%UserEvent{}, ...]

  """
  def list_users_events do
    Repo.all(UserEvent)
  end

  @doc """
  Gets a single user_event.

  Raises `Ecto.NoResultsError` if the User event does not exist.

  ## Examples

      iex> get_user_event!(123)
      %UserEvent{}

      iex> get_user_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_event!(id), do: Repo.get!(UserEvent, id)

  @doc """
  Creates a user_event.

  ## Examples

      iex> create_user_event(%{field: value})
      {:ok, %UserEvent{}}

      iex> create_user_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_event(attrs \\ %{}) do
    %UserEvent{}
    |> UserEvent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_event.

  ## Examples

      iex> update_user_event(user_event, %{field: new_value})
      {:ok, %UserEvent{}}

      iex> update_user_event(user_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_event(%UserEvent{} = user_event, attrs) do
    user_event
    |> UserEvent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserEvent.

  ## Examples

      iex> delete_user_event(user_event)
      {:ok, %UserEvent{}}

      iex> delete_user_event(user_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_event(%UserEvent{} = user_event) do
    Repo.delete(user_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_event changes.

  ## Examples

      iex> change_user_event(user_event)
      %Ecto.Changeset{source: %UserEvent{}}

  """
  def change_user_event(%UserEvent{} = user_event) do
    UserEvent.changeset(user_event, %{})
  end

  def add_user_to_event(%User{} = user, event) do
    add_user_to_event(user.id, event)
  end
  def add_user_to_event(user, %Event{} = event) do
    add_user_to_event(user, event.id)
  end
  def add_user_to_event(user_id, event_id) do
    params = %{user_id: user_id, event_id: event_id}
    UserEvent.changeset(%UserEvent{}, params)
    |> Repo.insert
  end

  def volunteers_for_organization(org_id) do
    #query = from user in User,
      #left_join: events in assoc(org, :events),
      #where: org.id == ^id,
      #preload: [events: events]

    #Repo.one(query)
  end
end
