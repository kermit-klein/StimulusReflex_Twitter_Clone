import consumer from "./consumer";
import CableReady from "cable_ready";

consumer.subscriptions.create("FeedChannel", {
  received(data) {
    if (data.CableReady) CableReady.perform(data.operations);
  },
});
