// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const dropdown = new bootstrap.Dropdown(this.element);
    console.log("Dropdown controller connected");
  }
}