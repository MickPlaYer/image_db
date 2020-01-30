//= require rails-ujs/lib/assets/compiled/rails-ujs
//= require activestorage
//= require turbolinks
//= require cable

document.addEventListener('DOMContentLoaded', function() {
  const goToTop = document.querySelector('.go-to-top');
  window.addEventListener('scroll', function() {
    if (window.scrollY > 600) {
      goToTop.classList.add('show');
    } else {
      goToTop.classList.remove('show');
    }
  });
  goToTop.addEventListener('click', function() {
    window.scrollTo({ behavior: 'smooth', top: 0 });
    goToTop.classList.remove('show');
    goToTop.blur();
  });
});
