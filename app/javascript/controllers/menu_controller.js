import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition'

export default class extends Controller {
  static targets = ['openButton', 'closeButton', 'mobileMenu', 'headerNav'];
  connect() {
    this.openButtonTarget.addEventListener('click', () => {
      enter(this.mobileMenuTarget)
    })
    this.closeButtonTarget.addEventListener('click', () => {
      leave(this.mobileMenuTarget);
    });

    this.headerNavTargets.forEach( (navLink) => {
      navLink.addEventListener('click', (e) => {
        e.preventDefault();

        document.getElementById(navLink.dataset.section).scrollIntoView({
          behavior: 'smooth'
        });
      });
    })

  }
}