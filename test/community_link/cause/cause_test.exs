defmodule CommunityLink.CauseTest do
  use CommunityLink.DataCase

  alias CommunityLink.Cause

  describe "organizations" do
    alias CommunityLink.Cause.Organization

    @valid_attrs %{name: "some name", description: "description"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def organization_fixture(attrs \\ %{}) do
      insert(:organization, attrs)
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert [returned_org] = Cause.list_organizations()
      assert returned_org.id == organization.id
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Cause.get_organization!(organization.id).id == organization.id
    end

    test "create_organization/1 with valid data creates a organization" do
      owner = insert(:user)
      attrs = @valid_attrs |> Map.put(:owner_id, owner.id)
      assert {:ok, %Organization{} = organization} = Cause.create_organization(attrs)
      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cause.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Cause.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Cause.update_organization(organization, @invalid_attrs)
      assert organization.id == Cause.get_organization!(organization.id).id
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Cause.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Cause.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Cause.change_organization(organization)
    end
  end

  describe "events" do
    alias CommunityLink.Cause.Event

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def event_fixture(attrs \\ %{}) do
      insert(:event, attrs)
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert [returned_event] = Cause.list_events()
      assert returned_event.id == event.id
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Cause.get_event!(event.id).id == event.id
    end

    test "create_event/1 with valid data creates a event" do
      organization = insert(:organization)
      attrs = @valid_attrs |> Map.put(:organization_id, organization.id)
      assert {:ok, %Event{} = event} = Cause.create_event(attrs)
      assert event.description == "some description"
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cause.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Cause.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.description == "some updated description"
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Cause.update_event(event, @invalid_attrs)
      assert event.id == Cause.get_event!(event.id).id
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Cause.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Cause.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Cause.change_event(event)
    end
  end
end
