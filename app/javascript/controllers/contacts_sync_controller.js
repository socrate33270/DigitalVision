import { Turbo } from "@hotwired/turbo-rails"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    interval: { type: Number, default: 5000 },
    url: String
  }

  connect() {
    this.requestInFlight = false
    this.visibilityHandler = this.handleVisibilityChange.bind(this)
    document.addEventListener("visibilitychange", this.visibilityHandler)
    this.startPolling()
  }

  disconnect() {
    document.removeEventListener("visibilitychange", this.visibilityHandler)
    this.stopPolling()
  }

  startPolling() {
    if (document.hidden) return

    this.stopPolling()
    this.timer = setInterval(() => this.refresh(), this.intervalValue)
  }

  stopPolling() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  handleVisibilityChange() {
    if (document.hidden) {
      this.stopPolling()
      return
    }

    this.refresh()
    this.startPolling()
  }

  async refresh() {
    if (this.requestInFlight) return

    this.requestInFlight = true

    try {
      const response = await fetch(this.urlValue, {
        headers: {
          Accept: "text/vnd.turbo-stream.html",
          "X-Requested-With": "XMLHttpRequest"
        },
        credentials: "same-origin"
      })

      if (!response.ok) return

      Turbo.renderStreamMessage(await response.text())
    } finally {
      this.requestInFlight = false
    }
  }
}
