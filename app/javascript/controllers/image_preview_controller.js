// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["previewContainer"]

  preview(event) {
    const input = event.target;
    const previewContainer = this.previewContainerTarget;

    previewContainer.innerHTML = ''; // Limpa o preview atual

    Array.from(input.files).forEach(file => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.width = '100px';
        img.style.height = '100px';
        img.style.marginRight = '10px';
        img.style.objectFit = 'cover';
        previewContainer.appendChild(img);
      };

      reader.readAsDataURL(file); // Lê o arquivo para pré-visualização
    });
  }
}
