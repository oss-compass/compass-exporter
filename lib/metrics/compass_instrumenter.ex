defmodule Metrics.CompassInstrumenter do

  use Prometheus.Metric

  def setup() do
    Gauge.declare([name: :token_stats, help: "Stats of all current working tokens.", labels: ["type"]])
    Gauge.declare([name: :token, help: "Latest status of current token.", labels: ["token", "type"]])
    Gauge.declare([name: :report_stats, help: "Stats of all current holding reports.", labels: ["origin", "type", "level"]])
  end

  def observe(name, value, labels) do
    Gauge.set([name: name, labels: labels], value)
  end
end