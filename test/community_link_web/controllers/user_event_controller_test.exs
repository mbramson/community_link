defmodule CommunityLinkWeb.UserEventControllerTest do
  use CommunityLinkWeb.ConnCase

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:user_event) do
    insert(:user_event)
  end

  describe "index" do
    test "lists all users_events", %{conn: conn} do
      conn = get conn, user_event_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users events"
    end
  end

  describe "new user_event" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_event_path(conn, :new)
      assert html_response(conn, 200) =~ "New User event"
    end
  end

  describe "create user_event" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = insert(:user)
      event = insert(:event)

      attrs = @create_attrs
              |> Map.put(:user_id, user.id)
              |> Map.put(:event_id, event.id)

      conn = post conn, user_event_path(conn, :create), user_event: attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_event_path(conn, :show, id)

      conn = get conn, user_event_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show User event"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = Plug.Conn.assign(conn, :users, [])
      conn = Plug.Conn.assign(conn, :events, [])
      conn = post conn, user_event_path(conn, :create), user_event: @invalid_attrs
      assert html_response(conn, 200) =~ "New User event"
    end
  end

  describe "edit user_event" do
    setup [:create_user_event]

    test "renders form for editing chosen user_event", %{conn: conn, user_event: user_event} do
      conn = get conn, user_event_path(conn, :edit, user_event)
      assert html_response(conn, 200) =~ "Edit User event"
    end
  end

  describe "update user_event" do
    setup [:create_user_event]

    test "redirects when data is valid", %{conn: conn, user_event: user_event} do
      conn = put conn, user_event_path(conn, :update, user_event), user_event: @update_attrs
      assert redirected_to(conn) == user_event_path(conn, :show, user_event)

      conn = get conn, user_event_path(conn, :show, user_event)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user_event: user_event} do
      conn = Plug.Conn.assign(conn, :users, [])
      conn = Plug.Conn.assign(conn, :events, [])
      conn = put conn, user_event_path(conn, :update, user_event), user_event: %{user_id: 9999999}
      assert html_response(conn, 200) =~ "Edit User event"
    end
  end

  describe "delete user_event" do
    setup [:create_user_event]

    test "deletes chosen user_event", %{conn: conn, user_event: user_event} do
      conn = delete conn, user_event_path(conn, :delete, user_event)
      assert redirected_to(conn) == user_event_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, user_event_path(conn, :show, user_event)
      end
    end
  end

  defp create_user_event(_) do
    user_event = fixture(:user_event)
    {:ok, user_event: user_event}
  end
end
