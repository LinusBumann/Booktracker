defmodule BooktrackerWeb.HelloController do
  use BooktrackerWeb, :controller

  def index(conn, _patams) do
    render(conn, :index)
  end
end
