defmodule Letsplay.PageController do
  use Letsplay.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
