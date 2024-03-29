defmodule Metrics.CompassInstrumenter do

  use Prometheus.Metric

  def setup() do
    Gauge.declare([name: :token_stats, help: "Stats of all current working tokens.", labels: ["type"]])
    Gauge.declare([name: :target_token, help: "Latest status of current token.", labels: ["token", "type"]])
    Gauge.declare([name: :report_stats, help: "Stats of all current holding reports.", labels: ["origin", "type", "level"]])
    Gauge.declare([name: :report_changes, help: "Changes of Compass's reports.", labels: ["action", "origin", "level", "range"]])
    Gauge.declare([name: :metadata_changes, help: "Changes of Compass's raw data.", labels: ["origin", "type", "range"]])
    Gauge.declare([name: :task_stats, help: "Stats of all task queues.", labels: ["desc"]])
    Gauge.declare([name: :user_stats, help: "Stats of all user.", labels: ["type"]])
    Gauge.declare([name: :lab_model_stats, help: "Stats of all lab model.", labels: ["type"]])
  end

  def observe(name, value, labels) do
    Gauge.set([name: name, labels: labels], value)
  end
end
