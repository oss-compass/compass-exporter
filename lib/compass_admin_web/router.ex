defmodule CompassAdminWeb.Router do
  use CompassAdminWeb, :router
  import Plug.BasicAuth


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CompassAdminWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :basic_auth, Application.get_env(:compass_admin, :basic_auth)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CompassAdminWeb do
    pipe_through :browser
    live "/admin", PageLive, :index
  end

  scope "/debug", CompassAdminWeb do
    pipe_through :api
    match :*, "/webhook", DebugController, :webhook
  end

  # Other scopes may use custom stacks.
  # scope "/api", CompassAdminWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  import Phoenix.LiveDashboard.Router

  scope "/admin" do
    pipe_through :browser
    live_dashboard "/dashboard",
      metrics: CompassAdminWeb.Telemetry,
      ecto_repos: [CompassAdmin.Repo],
      ecto_mysql_extras_options: [long_running_queries: [threshold: 200]]
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
