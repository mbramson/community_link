defmodule CommunityLinkWeb.PageControllerTest do
  use CommunityLinkWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Social Network"
  end
end
