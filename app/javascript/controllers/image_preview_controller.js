import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["previewContainer"];

  preview(event) {
    const input = event.target;
    const previewContainer = this.previewContainerTarget;

    // Limpa o preview atual
    previewContainer.innerHTML = ''; 

    // Oculta a imagem padrão
    const defaultImage = document.querySelector('.default-image');
    if (defaultImage) {
      defaultImage.style.display = 'none'; // Oculta a imagem padrão
    }

    const isMinimap = previewContainer.getAttribute('data-minimap') === 'true';

    Array.from(input.files).forEach(file => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement('img');
        img.src = e.target.result;

        // Estilos da imagem
        img.style.width = isMinimap ? '100px' : '100%'; // Tamanho menor para minimap
        img.style.height = isMinimap ? '100px' : '100%'; // Tamanho menor para minimap
        img.style.objectFit = 'cover'; // Ajusta a imagem dentro do espaço
        img.style.borderRadius = isMinimap ? '0%' : '50%'; // Quadrada para minimap, arredondada para padrão

        previewContainer.appendChild(img);
      };

      reader.readAsDataURL(file); // Lê o arquivo para pré-visualização
    });
  }
}