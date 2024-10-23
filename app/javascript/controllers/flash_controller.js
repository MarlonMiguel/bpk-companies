// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Define o tempo que a mensagem deve permanecer visível
    const displayDuration = 5000; // em milissegundos

    // Remove a mensagem após o tempo definido
    setTimeout(() => {
      this.element.classList.add('fade'); // Adiciona uma classe para efeitos de transição, se desejar
      setTimeout(() => {
        this.element.remove(); // Remove a mensagem do DOM
      }, 500); // Tempo para a transição antes de remover
    }, displayDuration);
  }
}
