// Menu manipulation
document.addEventListener("turbo:load", function()
{
  // Add toggle listener for the navbar dropdown menu
  let navbarToggle = document.getElementById("navbarNavToggle");
  let navbarMenu = document.getElementById("navbarNav");
  navbarToggle.addEventListener("click", function(event) {
    event.preventDefault();
    navbarMenu.classList.toggle("show");
  });

  // Add toggle listener for the account dropdown menu
  let accountToggle = document.getElementById("navbarDropdownMenuLink");
  let accountMenu = document.getElementById("navbarDropdownMenu");
  accountToggle.addEventListener("click", function(event) {
    event.preventDefault();
    accountMenu.classList.toggle("show");
  });
});
