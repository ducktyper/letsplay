defmodule Letsplay.PageController do
  use Letsplay.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def run(conn, _params) do
    redirect(conn, to: page_path(conn, :index))
  end
end
