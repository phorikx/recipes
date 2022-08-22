// Menu manipulation

// Add toggle listeners to listen for clicks.
function addMenuListener(main_menu_identifier, second_menu_identifier, action) {
  let hamburger = document.querySelector(main_menu_identifier);
  hamburger.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector(second_menu_identifier);
    menu.classList.toggle(action);
  });
}
document.addEventListener("turbo:load", function() {
  addMenuListener("#hamburger", "#navbar-menu", "collapse");
  addMenuListener("#account", "#dropdown-menu", "active");
});
