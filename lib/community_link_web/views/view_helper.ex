defmodule CommunityLinkWeb.ViewHelpers do

  @doc """
  Takes a list of Ecto structs, and outputs a list suitable for a select
  element on a Phoenix.HTML.form. The Ecto schema for the struct passed in must
  have a name property and an id property.
  """
  @spec data_as_select(List.t) :: [{binary(), integer()}]
  def data_as_select(data) do
    data
    |> Enum.map(&["#{&1.name}": &1.id])
    |> List.flatten
  end
end
