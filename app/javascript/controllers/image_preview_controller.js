import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["previewContainer"]

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

    Array.from(input.files).forEach(file => {
      const reader = new FileReader();

      reader.onload = (e) => {
        const img = document.createElement('img');
        img.src = e.target.result;

        // Estilos da imagem
        img.style.width = '100%'; // Largura 100% do contêiner
        img.style.height = '100%'; // Altura 100% do contêiner
        img.style.objectFit = 'cover'; // Ajusta a imagem dentro do espaço
        img.style.borderRadius = '50%'; // Adiciona bordas arredondadas

        previewContainer.appendChild(img);
      };

      reader.readAsDataURL(file); // Lê o arquivo para pré-visualização
    });
  }  
}