// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submenu"];

  /*connect() {
    if (window.innerWidth < 992) {
      this.closeSubmenusOnParentHide();
      this.setupSubmenuToggle();
    }
  }

  // Fecha todos os submenus quando o dropdown pai é oculto
  closeSubmenusOnParentHide() {
    this.element.querySelectorAll('.dropdown').forEach(dropdown => {
      dropdown.addEventListener('hidden.bs.dropdown', () => {
        dropdown.querySelectorAll('.submenu').forEach(submenu => {
          submenu.style.display = 'none';
        });
      });
    });
  }

  // Configura a alternância de exibição dos submenus ao clicar
  setupSubmenuToggle() {
    this.element.querySelectorAll('.dropdown-menu a').forEach(link => {
      link.addEventListener('click', (e) => {
        const nextEl = link.nextElementSibling;
        if (nextEl && nextEl.classList.contains('submenu')) {
          e.preventDefault();
          nextEl.style.display = nextEl.style.display === 'block' ? 'none' : 'block';
        }
      });
    });
  }*/
}
