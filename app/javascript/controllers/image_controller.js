// app/javascript/controllers/image_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  async delete(event) {
    event.preventDefault();

    const url = event.currentTarget.href; // Pega a URL da rota de exclusão
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    const response = await fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": token,
        "Accept": "application/json"
      }
    });

    if (response.ok) {
      this.containerTarget.remove(); // Remove a imagem da interface
    } else {
      console.error("Erro ao excluir a imagem");
    }
  }
}