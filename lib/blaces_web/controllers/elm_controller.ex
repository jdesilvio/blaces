defmodule BlacesWeb.ElmController do
  use BlacesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end